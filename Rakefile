require 'rake/testtask'
require_relative 'src/task_check.rb'
include TaskCheck

desc 'run all test'
task :default => [:test]

Rake::TestTask.new do |test|
  test.libs << 'test'
  test.test_files = Dir[ 'test/**/test_*.rb' ]
  test.verbose = true
end

task :cc_task do 
  puts task_check './task/continus-checker'
end

task :run do
  # puts task_check './task/test_task'
  # puts task_check './task/continus-checker'
  puts task_check './task/test_task_5'
end

task :view do
  task_view_with_reason './task/continus-checker'
end

task :view_test do
  task_view './task/test/reason/task1'
end

task :bundle_install do
  sh 'bundle install --path vendor/bundle'
end
