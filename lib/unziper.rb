class Unziper
  INVALID_ENTRIES = %w(__MACOSX .DS_STORE)

  class << self
    def get_files(zip_file)
      unziped_file = Zip::File.open_buffer(zip_file)
      unziped_file.select{|entry| entry.file? && valid_entry?(entry.name)}
    end

    private

    def valid_entry?(entry_name)
      INVALID_ENTRIES.none? {|pattern| entry_name =~ /#{pattern}/ }
    end
  end
end
