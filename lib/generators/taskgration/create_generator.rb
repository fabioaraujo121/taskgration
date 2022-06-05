require 'rails/generators'
module Taskgration
  module Generators
    class CreateGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      argument :name

      def set_version
        @version = Time.now.strftime("%Y%m%d%H%M%S")
      end

      def set_file_name
        @file_name = "#{@version}_#{name.underscore}"
      end

      def copy_file_to_main_app
        template('create.rb.tt', "lib/tasks/migrations/#{@file_name}.rb")
      end
    end
  end
end
