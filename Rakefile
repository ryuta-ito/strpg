require 'rake/testtask'
require './src/dirs.rb'
Dir.glob("./src/**/*.rb"){|file| require_relative file}
include TaskExtract
include EditControl
include View

task :default => [:test]

desc 'run all test'
Rake::TestTask.new do |test|
  test.libs << 'test'
  test.test_files = Dir[ 'test/**/test_*.rb' ]
  test.verbose = true
end

task :task do
  task_view Dirs::ALL_TASK_DIRS
end

namespace :task do
  task :test do
    task_view Dirs::TEST_TASK_DIRS
  end

  task :src do
    task_view Dirs::SRC_TASK_DIRS
  end
end

namespace :run do
  task :test do
    do_unwritable_all
    do_writable_files Dirs::ALL_TASK_DIRS
  end

  task :editable do
    do_writable_all
  end
end
