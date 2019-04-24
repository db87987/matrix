# frozen_string_literal: true

require 'spec_helper'
require 'uploader'

describe Uploader do
  let(:request_body) do
    'source=sentinels&start_node=alpha&end_node=alpha&start_time='\
    '2030-12-31T22%3A00%3A01&end_time=2030-12-31T22%3A09%3A01&'\
    'passphrase=Kans4s-i%24-g01ng-by3-bye'
  end
  let(:data) do
    {
      source: :sentinels,
      start_node: 'alpha',
      end_node: 'alpha',
      start_time: '2030-12-31T22:00:01',
      end_time: '2030-12-31T22:09:01',
      passphrase: 'Kans4s-i$-g01ng-by3-bye'
    }
  end

  before do
    stub_request(:post, 'https://challenge.distribusion.com/the_one/routes')
      .with(body: request_body)
  end

  it 'uploads data' do
    subject.upload(data: data)
  end
end
