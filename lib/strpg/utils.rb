module Strpg
  module Utils
    def get_pure_name file_path
      erase_file_identifier (get_file_name file_path)
    end

    def get_pure_test_name file_path
      (erase_file_identifier (get_file_name file_path)).split('_').tap {|arr| break ((arr.size > 1) ? arr[1] : '') }
    end

    def erase_file_identifier file_name
      (file_name.split('.').first)
    end

    def get_file_name file_path
      (file_path.split '/').last
    end

    def get_dir file_path
      (file_path.split '/').reverse.drop(1).reverse.join '/'
    end
  end
end
