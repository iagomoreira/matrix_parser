class Route
  attr_accessor :source, :start_node, :end_node, :start_time, :end_time

  def initialize(source:, start_node:, end_node: nil, start_time:, end_time: nil)
    @source = source
    @start_node, @end_node = start_node, end_node
    @start_time, @end_time = start_time, end_time
  end

  def finished?
    !@end_node.nil? && !@end_time.nil?
  end
end
