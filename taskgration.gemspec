require_relative "lib/taskgration/version"

Gem::Specification.new do |spec|
  spec.name        = "taskgration"
  spec.version     = Taskgration::VERSION
  spec.authors     = ["Fábio Araújo"]
  spec.email       = ["fabioaraujo121@gmail.com"]
  spec.homepage    = "https://github.com/fabioaraujo121/taskgration"
  spec.summary     = "Track tasks like migrations"
  spec.description = "Know what tasks ran and keep the track of it"
  spec.license     = "MIT"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/fabioaraujo121/taskgration"
  spec.metadata["changelog_uri"] = "https://github.com/fabioaraujo121/taskgration/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 5.2"
  # spec.add_development_dependency "generator_spec"
end
