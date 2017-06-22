require 'spec_helper'

RSpec.describe Route do
  describe '#finished?' do
    subject { route.finished? }

    context 'when route is not finished' do
      let(:route) { Route.new(source: 'sentinels', start_node: 'tau', start_time: Time.now) }

      it { is_expected.to be false }
    end

    context 'when route is finished' do
      let(:route) do
        Route.new(
          source: 'sentinels',
          start_node: 'tau',
          start_time: Time.now-5,
          end_node: "lambda",
          end_time: Time.now)
      end

      it { is_expected.to be true }
    end
  end
end
