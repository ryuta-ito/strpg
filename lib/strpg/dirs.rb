require_relative 'config.rb'

module Dirs
  config = Config::YamlFile.new
  WRITABLE_DIRS = config.all_strict_files
  ALL_TASK_DIRS = Dir.glob('./task/**/task_*')
  TEST_TASK_DIRS = Dir.glob('./task/test/**/task_*')
  SRC_TASK_DIRS = Dir.glob('./task/lib/**/task_*')
  SAPMLE_TASK_DIRS = Dir.glob('./task/sample/**')
end
