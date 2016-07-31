require 'strpg/config'
require 'strpg/dirs'
require 'strpg/edit_control'
require 'strpg/factory'
require 'strpg/line'
require 'strpg/task'
require 'strpg/task_extract'
require 'strpg/task_manager'
require 'strpg/view'
require 'thor'
require 'fileutils'

include Strpg::TaskExtract
include Strpg::EditControl
include Strpg::View
