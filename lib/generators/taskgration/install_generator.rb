require 'rails/generators'
module Taskgration
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def code_that_runs
        puts 'hi'
      end
    end
  end
end
