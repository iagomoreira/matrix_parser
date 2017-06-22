class BaseParser
  def self.call(entries)
    new(entries).call
  end

  def convert_time(time)
    time.utc.iso8601
  end

  def parse_time(time)
    convert_time(Time.parse(time))
  end

  def read_file(file_name)
    @entries.find{|e| e.name =~ /#{file_name}/ }.get_input_stream.read
  end
end
