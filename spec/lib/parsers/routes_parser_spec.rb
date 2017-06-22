require 'spec_helper'

RSpec.describe RoutesParser do
  let(:loopholes_routes) { double('loopholes_routes') }
  let(:sentinels_routes) { double('sentinels_routes') }
  let(:sniffers_routes) { double('sniffers_routes') }

  let(:entries) { double('entries')}

  before do
    allow(RoutesClient).to receive(:loopholes).and_return(entries)
    allow(RoutesClient).to receive(:sentinels).and_return(entries)
    allow(RoutesClient).to receive(:sniffers).and_return(entries)

    allow(LoopholesParser).to receive(:call).and_return([loopholes_routes])
    allow(SentinelsParser).to receive(:call).and_return([sentinels_routes])
    allow(SniffersParser).to receive(:call).and_return([sniffers_routes])
  end

  describe '.call' do
    it 'fetch routes for each known source' do
      expect(RoutesClient).to receive(:loopholes)
      expect(RoutesClient).to receive(:sentinels)
      expect(RoutesClient).to receive(:sniffers)

      described_class.call
    end

    it 'returns a list of parsed routes' do
      expect(described_class.call).to eq [loopholes_routes, sentinels_routes, sniffers_routes]
    end
  end
end
