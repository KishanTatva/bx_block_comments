$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "bx_block_comments/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "bx_block_comments"
  spec.version     = BxBlockComments::VERSION
  spec.authors     = ["KishanTatva"]
  spec.email       = ["kishan.jivani@tatvasoft.com"]
  spec.homepage    = "https://rubygems.org/gems/example"
  spec.summary     = " Summary of BxBlockComments."
  spec.description = " Description of BxBlockComments."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://github.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  
  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.2"

  spec.add_development_dependency "sqlite3"
  spec.add_dependency 'builder_base'
  spec.add_dependency 'builder_json_web_token'
  spec.add_dependency 'account_block'
  spec.add_dependency 'bx_block_login-3d0582b5'
  
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'rake_tasks'
  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'account_block'

  spec.test_files = Dir["spec/**/*"]

end
