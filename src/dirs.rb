module Dirs
  WRITABLE_DIRS = Dir.glob('./test/**') + Dir.glob('./src/**') + ['./Rakefile']
  ALL_TASK_DIRS = Dir.glob('./task/**/task_*')
  TEST_TASK_DIRS = Dir.glob('./task/test/**/task_*')
  SRC_TASK_DIRS = Dir.glob('./task/src/**/task_*')
  SAPMLE_TASK_DIRS = Dir.glob('./task/sample/**')
end
