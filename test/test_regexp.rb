require 'strpg/task_extract'
require 'test/unit'

class TestLine < Test::Unit::TestCase
  include TaskExtract

  def test_regexp
    l = Line.new('- task')
    assert_equal [true, false, false, false], [l.task?, l.reason?, l.file_striction?, l.result?]

    l = Line.new('  <- reason')
    assert_equal [false, true, false, false], [l.task?, l.reason?, l.file_striction?, l.result?]

    l = Line.new('  * file/path')
    assert_equal [false, false, true, false], [l.task?, l.reason?, l.file_striction?, l.result?]

    l = Line.new('  -> task')
    assert_equal [false, false, false, true], [l.task?, l.reason?, l.file_striction?, l.result?]
  end
end
