$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'rake/testtask'

task :default => [:test]

desc 'run all test'
Rake::TestTask.new do |test|
  test.libs << 'test'
  test.test_files = Dir[ 'test/**/test_*.rb' ]
  test.verbose = true
end
