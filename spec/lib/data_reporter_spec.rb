require 'spec_helper'

RSpec.describe DataReporter do
  describe '.call' do
    let(:start_time) { Time.now.utc.iso8601 }
    let(:end_time) { (Time.now+1000).utc.iso8601  }
    let(:parsed_routes) do
      [
        Route.new(source: 'loopholes', start_time: start_time, end_time: end_time, start_node: "beta", end_node: "delta"),
        Route.new(source: 'sentinels', start_time: start_time, end_time: end_time, start_node: "tau", end_node: "lambda"),
        Route.new(source: 'sniffers', start_time: start_time, end_time: end_time, start_node: "gamma", end_node: "alpha")
      ]
    end

    before do
      allow(RoutesParser).to receive(:call).and_return(parsed_routes)
    end

    it 'sends parsed routes to the system 3 times' do
      expect(RoutesClient).to receive(:push_route).exactly(3).times

      described_class.call
    end
  end
end
