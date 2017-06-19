require 'spec_helper'

RSpec.describe Unziper do
  let(:invalid_entry) do
    double('entry', file?: true, name: '__MACOSX/path/file')
  end

  let(:folder_entry) do
    double('entry', file?: false, name: 'path/folder')
  end

  let(:valid_entry) do
    double('entry', file?: true, name: 'path/file.csv')
  end

  let(:entries) { [invalid_entry, folder_entry, valid_entry] }

  before do
    allow(Zip::File).to receive(:open_buffer).and_return(entries)
  end

  describe '.get_files' do
    it 'returns only the valid entries' do
      expect(described_class.get_files('zipfile')).to eq [valid_entry]
    end
  end
end
