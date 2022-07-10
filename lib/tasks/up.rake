require 'pathname'
require 'fileutils'

namespace :taskgration do
  desc 'Run this task if you want to apply the latest tasks migrations'
  task up: :environment do
    started_at      = Time.now
    root_path       = 'lib/tasks/migrations'
    executed_files  = []
    all_versions    = Taskgration::TaskMigration.pluck(:version)

    Dir.foreach(root_path).sort.each do |filename|
      next if filename == '.' || filename == '..'

      basename = File.basename(filename, '.rb')
      version  = basename.split(/_/).first.to_i

      if all_versions.exclude?(version)
        load "#{Dir.pwd}/#{root_path}/#{filename}"

        basename    = File.basename(filename, '.rb')
        module_name = basename.split(/_/)[1..-1]
        module_name = module_name.join('_').camelcase 

        module_name.constantize.new.up

        executed_files << filename

        Taskgration::TaskMigration.create!(name: module_name.underscore, version: version)
      end
    end

    print "\n\nTasks migrated in #{Time.at(Time.now - started_at).utc.strftime('%H hours %M minutes and %S seconds')}.\n"
    print "Current version is: #{Taskgration::TaskMigration.current_version}\n\n"

    abort("NOTHING NEW TO RUN...") if executed_files.empty?

    print "FILES MIGRATED:\n"
    print executed_files.map{ |name| "    #{name}" }.join("\n")
  end
end
