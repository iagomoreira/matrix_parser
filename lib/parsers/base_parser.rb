class BaseParser
  def self.call(entries)
    new(entries).call
  end

  def initialize(entries)
    @entries = entries
  end
end
