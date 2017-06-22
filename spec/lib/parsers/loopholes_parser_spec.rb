require 'spec_helper'

RSpec.describe LoopholesParser do
  describe '.call' do
    let(:node_pair_file) do
      StringIO.new({"node_pairs"=>
        [
          {"id"=>"1", "start_node"=>"gamma", "end_node"=>"theta"}
        ]
      }.to_json)
    end

    let(:routes_file) do
      StringIO.new({"routes"=>
        [
          {"route_id"=>"1", "node_pair_id"=>"1", "start_time"=>"2030-12-31T13:00:04Z", "end_time"=>"2030-12-31T13:00:05Z"},
          {"route_id"=>"3", "node_pair_id"=>"9", "start_time"=>"2030-12-31T13:00:00Z", "end_time"=>"2030-12-31T13:00:00Z"}
        ]
      }.to_json)
    end

    let(:entries) do
      [
        double('entry', name: 'routes.json', get_input_stream: routes_file),
        double('entry', name: 'node_pairs.json', get_input_stream: node_pair_file)
      ]
    end

    it "doesn't add file if it is from an unknown node pair" do
      expect(described_class.call(entries).count).to eq 1
    end

    describe 'parsed route' do
      subject { described_class.call(entries).first }

      it 'returns data from teh first rout and node_pair' do
        expect(subject.source).to eq "loopholes"
        expect(subject.start_time).to eq "2030-12-31T13:00:04Z"
        expect(subject.end_time).to eq "2030-12-31T13:00:05Z"
        expect(subject.start_node).to eq "gamma"
        expect(subject.end_node).to eq "theta"
      end
    end
  end
end
