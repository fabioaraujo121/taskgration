require 'pathname'
require 'fileutils'

namespace :taskgration do
  desc 'Run this task if you want to apply the latest tasks migrations'
  task down: :environment do
    started_at      = Time.now
    root_path       = 'lib/tasks/migrations'
    files_to_run    = []

    if ENV['TASKGRATION_VERSION'].present?
      target_version = ENV['TASKGRATION_VERSION'].to_i
      taskgration    = Taskgration::TaskMigration.find_by_version!(target_version)
      files_to_run << "#{target_version}_#{taskgration.name}"
    elsif ENV['TASKGRATION_STEPS'].present?
      quantity    = ENV['TASKGRATION_STEPS'].to_i
      taskgration = Taskgration::TaskMigration.newest.limit(quantity)

      taskgration.each { |t| files_to_run << "#{t.version}_#{t.name}" }
    else
      taskgration = Taskgration::TaskMigration.newest.first
      files_to_run << "#{taskgration.version}_#{taskgration.name}"
    end

    files_to_run.each do |filename|
      load "#{Dir.pwd}/#{root_path}/#{filename}.rb"

      module_name = filename.split(/_/)[1..-1]
      module_name = module_name.join('_').camelcase 

      module_name.constantize.new.down
    end

    print "\n\nTasks migrated in #{Time.at(Time.now - started_at).utc.strftime('%H hours %M minutes and %S seconds')}.\n"

    abort("NOTHING TO RUN...") if files_to_run.empty?

    print "FILES MIGRATED:\n"
    print files_to_run.map{ |name| "    #{name}" }.join("\n")
  end
end
