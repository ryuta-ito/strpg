require "bundler/gem_tasks"
require 'strpg'
require 'rake/testtask'

task :default => [:test]

desc 'run all test'
Rake::TestTask.new do |test|
  test.libs << 'test'
  test.test_files = Dir[ 'test/**/test_*.rb' ]
  test.verbose = true
end
