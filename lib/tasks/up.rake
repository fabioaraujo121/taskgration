require 'pathname'
require 'fileutils'

namespace :taskgration do
  desc 'Run this task if you want to apply the latest tasks migrations'
  task up: :environment do
    started_at = Time.now
    current_version = Taskgration::TaskMigration.current_version

    ##
    # 1. Getting files newer than current version in DB
    # 2. Running each available file
    # 3. Save current version in DB
    root_path = 'lib/tasks/migrations'
    files_to_run = []
    Dir.foreach(root_path).reverse_each do |filename|
      next if filename == '.' || filename == '..'

      basename = File.basename(filename, '.rb')
      version  = basename.split(/_/).first.to_i

      if version > current_version
        load "#{Dir.pwd}/#{root_path}/#{filename}"

        basename    = File.basename(filename, '.rb')
        module_name = basename.split(/_/)[1..-1]
        module_name = module_name.join('_').camelcase

        module_name.constantize.new.up

        files_to_run << filename
        current_version = version

        # TODO save current migration in DB
        Taskgration::TaskMigration.create!(name: module_name.underscore, version: current_version)
      end
    end

    print "Tasks migrated in #{Time.at(Time.now - started_at).utc.strftime('%H hours %M minutes and %S seconds')}.\n"
    print "Current version is: #{current_version}\n\n"

    abort("NOTHING NEW TO RUN...") if files_to_run.empty?

    print "FILES MIGRATED:\n"
    print files_to_run.map{ |name| "    #{name}" }.join("\n")
  end
end
