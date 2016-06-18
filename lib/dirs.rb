module Dirs
  WRITABLE_DIRS = Dir.glob('./test/**') + Dir.glob('./lib/**') + ['./Rakefile']
  ALL_TASK_DIRS = Dir.glob('./task/**/task_*')
  TEST_TASK_DIRS = Dir.glob('./task/test/**/task_*')
  SRC_TASK_DIRS = Dir.glob('./task/lib/**/task_*')
  SAPMLE_TASK_DIRS = Dir.glob('./task/sample/**')
  class Yaml
  end
end
