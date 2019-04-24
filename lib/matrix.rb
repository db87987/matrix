# frozen_string_literal: true

require_relative 'fetcher'
require_relative 'uploader'
require_relative 'parser'
require_relative 'parser/sniffers_parser'
require_relative 'parser/sentinels_parser'
require_relative 'parser/loopholes_parser'

require 'pry'

sources = %i[sentinels sniffers loopholes]
uploader = Uploader.new

sources.each do |source|
  print "Fetching #{source}..."
  raw_data = Fetcher.new(source: source).fetch
  puts "#{source} data imported!"

  print "Processing #{source} data..."
  parser = "#{source}Parser".camelcase.constantize
  parsed_data = parser.new(data: raw_data).parse
  puts "#{source} data parsed successfully!"

  puts "Uploading #{source} data, here it comes..."
  parsed_data.each { |data| uploader.upload(data: data) }
  puts "Uploading #{source} data completed!"
end

puts 'Uploading for all sources completed!'
