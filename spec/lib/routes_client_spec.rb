require 'spec_helper'

RSpec.describe RoutesClient do
  let(:query_params) do
    {
      query: {passphrase: 'foo', source: source}
    }
  end

  let(:entries) { double('entries') }

  before do
    allow(ENV).to receive(:fetch).with('ROUTES_URI').and_return('http://matrix.com')
    allow(ENV).to receive(:fetch).with('ROUTES_PASSPHRASE').and_return('foo')
    allow(described_class).to receive(:get).with('/routes', query_params).and_return('response')
    allow(Unziper).to receive(:get_files).and_return(entries)
  end

  describe '.loopholes' do
    let(:source) { 'loopholes' }

    it 'returns unziped response' do
      expect(described_class.loopholes).to eq entries
    end
  end

  describe '.sentinels' do
    let(:source) { 'sentinels' }

    it 'returns unziped response' do
      expect(described_class.sentinels).to eq entries
    end
  end

  describe '.sniffers' do
    let(:source) { 'sniffers' }

    it 'returns unziped response' do
      expect(described_class.sniffers).to eq entries
    end
  end
end
