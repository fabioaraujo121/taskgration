namespace :taskgration do
  desc 'Run this task if you want to apply the latest tasks migrations'
  task up: :environment do
    puts 'Hello'
  end
end
