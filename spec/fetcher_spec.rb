# frozen_string_literal: true

require 'spec_helper'
require 'fetcher'

describe Fetcher do
  let(:source) { :sniffers }
  let(:url) do
    'https://challenge.distribusion.com/the_one/routes?'\
    'passphrase=Kans4s-i$-g01ng-by3-bye&source=sniffers'
  end

  it 'fetches data' do
    VCR.use_cassette("fetch_#{source}") do
      described_class.new(source: source).fetch
    end
  end
end
