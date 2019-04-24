# frozen_string_literal: true

require 'spec_helper'
require 'parser/sniffers_parser'
require 'pry'

describe SniffersParser do
  let(:raw_data) do
    JSON.parse(File.read('spec/fixtures/parser_raw_data/sniffers_raw_data.json'))
  end
  let(:parsed_keys) { %i[source start_node end_node start_time end_time] }

  it 'parses raw data' do
    parsed_data = described_class.new(data: raw_data).parse
    expect(parsed_data.length).to eq(4)
    expect(parsed_data.first.keys).to eq(parsed_keys)
  end
end
