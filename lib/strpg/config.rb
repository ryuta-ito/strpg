require 'yaml'

module Config
  class YamlFile
    def initialize yaml_file_path=nil
      yaml_file_path ||= './strpg.yml'
      begin
        @yaml_hash = YAML.load_file yaml_file_path
      rescue
        @yaml_hash = {"strict_dirs" => [], "strict_files" => []}
      end
    end

    def strict_dirs
      @yaml_hash["strict_dirs"]
    end

    def strict_files
      @yaml_hash["strict_files"]
    end

    def developmenting_dirs
      @yaml_hash[__method__.to_s]
    end

    def all_strict_files
      files = (strict_dirs + strict_files).map do |file|
        Dir[file]
      end.reduce(&:+)
      files.nil? ? [] : files
    end
  end
end
