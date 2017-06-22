require 'spec_helper'

RSpec.describe RoutesClient do
  context 'GET /routes' do
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

  context 'POST /routes' do
    describe '.push_route' do
      let(:response) { double('response') }
      let(:expected_body) do
        { body: {
            source: 'sentinels',
            start_node: 'lambda',
            end_node: 'tau',
            start_time: "2030-12-31T13:00:06",
            end_time: "2030-12-31T13:00:07",
            passphrase: "Kans4s-i$-g01ng-by3-bye"
          }
        }
      end
      before do
        allow(described_class).to receive(:post)
          .with("/routes", expected_body)
          .and_return(response)
      end

      it 'returns api response' do
        expect(described_class.push_route('sentinels', 'lambda', 'tau', "2030-12-31T13:00:06", "2030-12-31T13:00:07"))
          .to eq response
      end
    end
  end
end
