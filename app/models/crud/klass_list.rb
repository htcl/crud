# Processor to create a list of models
module Crud
  class KlassList
    def initialize
      update
    end

    def update
      #return if $all_klasses
      all_model_names = []
      ::Crud.model_path.each do |path_element|
        model_files = Dir[ File.join(path_element, '**', '*.rb').to_s ]
        model_names = model_files.map { |item| item.sub(path_element,'').sub(/^\//,'').sub(/\.rb$/,'').camelize.gsub(File::SEPARATOR,'::') }
        all_model_names += model_names
      end

      klasses = create_klasses_from_model_names(all_model_names)
      #Rails.logger.debug "create_klasses_from_model_names()"
      #klasses.each {|klass| Rails.logger.debug "#{klass}"}

      $all_klasses = remove_klasses_without_table(klasses).sort_by {|r| r.name.underscore}
      Rails.logger.debug "$all_klasses"
      $all_klasses.each {|klass| Rails.logger.debug "#{klass} (#{klass.name.underscore})"}
    end

    def all
      $all_klasses
    end

    private

    def create_klasses_from_model_names(model_names)
      output = Array.new
      klass_names = model_names.select {|model_name| (model_name.constantize.is_a? Class) && !(model_name == 'ApplicationRecord')}
      klass_names.each do |klass_name|
        begin
          klass = Object.const_get(klass_name)
          output << klass if klass_name == klass.to_s
        rescue Exception => e
          Rails.logger.debug e.message
        end
      end
      output
    end

    def remove_klasses_without_table(klasses)
      klasses.select { |klass| klass.ancestors.include?(ActiveRecord::Base) && klass.connection.table_exists?(klass.table_name) }
    end
  end
end

# p.to_s if p.respond_to?(:to_s) && /^<.+>$/.match(p.to_s).nil?