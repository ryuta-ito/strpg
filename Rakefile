require 'rake/testtask'
Dir.glob("./src/**/*.rb"){|file| require_relative file}
include TaskCheck
include EditControl

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
  puts task_check './task/test_task_5'
end

task :view do
  task_view_with_reason './task/test/edit_control'
end

task :test_edit_control do
  
end

task :view_test do
  task_view './task/test/reason/task1'
end

task :editable do
  do_writable_all
end

task :uneditable do
  do_unwritable_all
end

