# frozen_string_literal: true

require 'parser/loopholes_parser'
require 'pry'

describe LoopholesParser do
  let(:raw_data) do
    JSON.parse(File.read('spec/fixtures/parser_raw_data/loopholes_raw_data.json'))
  end
  let(:parsed_keys) { %i[source start_node end_node start_time end_time] }

  it 'parses raw data' do
    parsed_data = described_class.new(data: raw_data).parse
    expect(parsed_data.length).to eq(3)
    expect(parsed_data.first.keys).to eq(parsed_keys)
  end
end
