# frozen_string_literal: true

require 'zip'
require_relative 'request_common'

# Gets data from sources
class Fetcher
  include RequestCommon

  def initialize(source:)
    @source = source
  end

  def fetch
    http = Curl.get(url)
    unzip(http.body_str)
  end

  private

  def url
    "#{BASE_URL}?passphrase=#{PASSPHRASE}&source=#{@source}"
  end

  def unzip(response)
    {}.tap do |memo|
      Zip::File.open_buffer(response) do |archive|
        archive.each do |entry|
          next if entry.directory? || entry.name.match(/__MACOSX/)

          memo[entry.name] = entry.get_input_stream.read
        end
      end
    end
  end
end
