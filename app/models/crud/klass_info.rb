# Model data
module Crud
  class KlassInfo < Hash

    def initialize(class_name)
      self[:name] = class_name.to_s
      namespace_parts = self[:name].match(/(.+)::(.+)/)
      self[:namespace] = namespace_parts ? "::#{namespace_parts[1]}::" : ''
      self[:name_as_sym] = self[:name].gsub(/::/,'_').underscore.to_sym
      self[:class] = self[:name].constantize
      self[:column_settings] = ::Crud.column_settings.select {|v| [self[:name], 'all'].include?(v[:class].to_s)}
      self[:custom_fields] = ::Crud.custom_fields.select {|v| v[:class] == self[:name]}
      self[:custom_fields].each {|field| field[:additional_partial_parameters] ||= {}}

      if self[:class].respond_to?(:reflections)

        self[:attributes] = []

        self[:class].columns.each_index do |i|
          self[:attributes][i] = {}
          self[:attributes][i][:column_name] = self[:class].column_names[i]
          self[:attributes][i][:column_class_type] = self[:class].column_names[i].class
          self[:attributes][i][:column_data_type] = self[:class].columns[i].type

          # Initialise belongs_to associations
          reflection_value = belongs_to_reflection_values.select {
            |k| k.name == self[:attributes][i][:column_name].sub(/_id$/,'').to_sym
          }[0]

          if reflection_value
            self[:attributes][i][:association] = reflection_value.macro
            self[:attributes][i][:association_polymorphic] = reflection_value.options[:polymorphic] ? reflection_value.options[:polymorphic] : false
            self[:attributes][i][:association_class] = association_class_for_reflection_value(reflection_value, :belongs_to, self[:attributes][i])
          end
        end

        self[:has_one] = []
        self[:has_many] = []
        self[:has_and_belongs_to_many] = []

        has_one_reflection_values.each_with_index do |reflection_value, i|
          self[:has_one][i] = {}
          self[:has_one][i][:association_name] = reflection_value.name
          self[:has_one][i][:association_class] = association_class_for_reflection_value(reflection_value, :has_one)
        end

        has_many_reflection_values.each_with_index do |reflection_value, i|
          self[:has_many][i] = {}
          self[:has_many][i][:association_name] = reflection_value.name
          self[:has_many][i][:association_class] = association_class_for_reflection_value(reflection_value, :has_many)
        end

        habtm_reflection_values.each_with_index do |reflection_value, i|
          self[:has_and_belongs_to_many][i] = {}
          self[:has_and_belongs_to_many][i][:association_name] = reflection_value.name
          self[:has_and_belongs_to_many][i][:association_class] = association_class_for_reflection_value(reflection_value, :has_and_belongs_to_many)
        end
      end
    end

    def primary_key(klass)
      klass.respond_to?(:primary_key) ? klass.primary_key : 'id'
    end

    def self.primary_key_is_id?(klass)
      (klass.respond_to?(:primary_key) && klass.primary_key == 'id')
    end

    def row_id(row)
      row.send( self.primary_key(row) )
    end

    def attribute_value_from_row(attribute, row)
      if attribute[:association] == :belongs_to
        association_id = row.attributes[attribute[:column_name]].to_i

        unless(attribute[:association_polymorphic])
          association_value = attribute[:association_class].find(association_id)
        else
          associated_attribute = associated_polymorphic_attribute(attribute)
          if associated_attribute && associated_attribute.length == 1
            association_value = row.attributes[associated_attribute[0][:column_name]].constantize.find(association_id)
          end
        end unless (association_id==0)
      end

      ["#{row.attributes[attribute[:column_name]]}", (association_value ? "#{association_value}" : nil)]
    end

    def associated_polymorphic_class(attribute, row = nil)
      associated_class = nil
      if (row)
        associated_attribute = associated_polymorphic_attribute(attribute)
        if associated_attribute && associated_attribute.length == 1 && row.attributes[associated_attribute[0][:column_name]]
          associated_class = row.attributes[associated_attribute[0][:column_name]].constantize
        end
      end
      associated_class
    end

    def associated_polymorphic_attribute(attribute)
      self[:attributes].select do |attr|
        attr[:column_name] == attribute[:column_name].sub(/_id$/,"_type")
      end if attribute[:association_polymorphic]
    end

    def visible_attributes(page)
      self[:attributes].select { |v| is_visible_attribute?(v[:column_name], page) }
    end

    def is_visible_attribute?(column, page)
      ( self[:column_settings].select {|v| (v[:hidden_fields] ? v[:hidden_fields].include?(column.to_sym) : false) && (v[:only] ? v[:only].include?(page.to_sym) : true)} ).empty?
    end

    def custom_fields(column, page = nil)
      self[:custom_fields].select {|v| (v[:column_name] ? v[:column_name] == column.to_s : false) && (v[:global] ? v[:global] == false : true) && ((page && v[:only]) ? v[:only].include?(page.to_sym) : true)}
    end

    def global_custom_fields(page = nil)
      self[:custom_fields].select {|v| (v[:global] ? v[:global] == true : false) && ((page && v[:only]) ? v[:only].include?(page.to_sym) : true)}
    end

    def custom_fields_contain_a_replacement(fields)
      replacement_fields = fields.select {|v| (v[:column_replacement] ? v[:column_replacement] == true : false)}
      (replacement_fields.length > 0)
    end

    private

    def belongs_to_reflection_values()
      reflection_values_for_klass(:belongs_to)
    end

    def has_one_reflection_values()
      reflection_values_for_klass(:has_one)
    end

    def has_many_reflection_values()
      reflection_values_for_klass(:has_many)
    end

    def habtm_reflection_values()
      reflection_values_for_klass(:has_and_belongs_to_many)
    end

    def reflection_values_for_klass(association_type)
      self[:class].reflections.values.select do |value|
        value.macro == association_type
      end
    end

    def association_class_for_reflection_value(reflection_value, association_type, attribute = nil, row = nil)
      association_class = reflection_value.options[:class_name] ?
        reflection_value.options[:class_name].to_s.sub(/^class_name/,'') :
        [:has_many, :has_and_belongs_to_many].include?(association_type) ?
        "#{self[:namespace]}#{reflection_value.name.to_s.camelize.classify}" : "#{self[:namespace]}#{reflection_value.name.to_s.camelize}"

      if (attribute && attribute[:association_polymorphic])
        associated_polymorphic_class(attribute, row)
      else
        association_class.constantize
      end
    end

  end
end
