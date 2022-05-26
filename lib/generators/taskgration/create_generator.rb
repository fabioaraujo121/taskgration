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
        @file_name = "#{@version}_#{snakecase(name)}"
      end

      def copy_file_to_main_app
        template('create.rb.tt', "lib/tasks/migrations/#{@file_name}.rb")
      end

      private
        def snakecase(str)
          str.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr('-', '_').
          gsub(/\s/, '_').
          gsub(/__+/, '_').
          downcase
        end
    end
  end
end
