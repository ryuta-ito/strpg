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

task :strict do
  do_writable_only_strict_file
end

namespace :strict do
  task :test do
  end

  task :reset do
    do_writable_all
  end
end
