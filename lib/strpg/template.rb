require 'strpg/utils'

module Strpg
  class Template
    include Strpg::Utils

    def initialize created_file_path
      @pure_name = get_pure_name created_file_path
      @pure_test_name = get_pure_test_name created_file_path
    end

    def lib_template
      File.open './template/lib.erb' do |f|
        cap_prj_name = 'Strpg' # its hard cording
        cap_pure_name = @pure_name.capitalize
        ERB.new(f.read).result(binding)
      end
    end

    def test_template
      File.open './template/test.erb' do |f|
        cap_pure_test_name = @pure_test_name.capitalize
        ERB.new(f.read).result(binding)
      end
    end
  end
end
