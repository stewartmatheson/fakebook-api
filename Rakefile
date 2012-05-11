$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
  RSpec::Core::RakeTask.new do |t|
end

desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end

desc "Build the Gem"
task :build do
  system "gem build fakebook-api.gemspec"
end
 
desc "Release to ruby gems"
task :release => :build do
  system "gem push fakebook-api-#{FakebookAPI::VERSION}.gem"
  system "rm fakebook-api-#{FakebookAPI::VERSION}.gem"
end
