# Development Menu
module Crud
  class Menus::DevelopmentMenu < Hash
    def initialize
      root_dir = Crud::Engine.root

      Dir.glob( File.join(root_dir, 'app', 'controllers', '**', '*_controller.rb') ).sort.each do |controller_file|
        controller_prefix = File.dirname( controller_file.gsub(/^.*controllers/, "").gsub(/^[\\\/]/, "") )
        controller_prefix = (controller_prefix.length == 1) ? '' : controller_prefix + '/'
        controller = File.basename(controller_file, ".rb")
        controller_object = controller.camelize

        model_prefix = controller_prefix.gsub(/^.*admin/,"").gsub(/^[\\\/]/, "")
        model = controller.gsub("_controller","").singularize
        model_object = model.camelize

        if File.exist?( File.join(root_dir, 'app', 'models', model_prefix, model + '.rb') )
          next if ['report'].include?(model)

          #link_text = t(model + '.object_name').to_s.humanize
          #link_text = t(model + '.object_name').to_s.humanize.pluralize
          link_text = model.to_s.humanize.pluralize
          controller_for_url = "#{controller_prefix}#{controller.gsub("_controller","")}"
          action_for_url = 'index'

          # Initialise section reference
          section = self

          controller_prefix.split(File::SEPARATOR).each do |sub_section|
            if section[sub_section].nil?
              section[sub_section] = Hash.new
              #section[sub_section]['name'] = sub_section.to_s.humanize
            end
            section = section[sub_section]
          end

          section = Hash.new if section.nil?
          section[controller] = Hash.new if section[controller].nil?
          section[controller]['name'] = link_text
          section[controller]['controller'] = controller_for_url
          section[controller]['action'] = action_for_url
        end
      end
    end

    def depth(menu = self, count = 0)
      count += 1

      menu.each do |key, value|
        break if value.class != Hash || value.has_key?('controller')

        tmp_depth = depth(value, count)
        count = tmp_depth if tmp_depth > count
      end

      count
    end

    def items
      self
    end
  end
end
