class TestEditControl < Test::Unit::TestCase
  def test_read_strpg_yml_and_correctly_set
    yaml = Config::YamlFile.new './sample/strpg.yml'
    assert_equal ['./lib/*', './*'], yaml.strict_dirs
    assert_equal ['./doc/initiative'], yaml.strict_files
  end
end

