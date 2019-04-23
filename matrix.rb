# frozen_string_literal: true

require 'curb'
require 'pry'
require 'zip'
require 'csv'
require 'active_support/all'

require './request_common'
require './fetcher'
require './uploader'
require './parser'
require './parser/sniffers_parser'
require './parser/sentinels_parser'
require './parser/loopholes_parser'

sources = %i[sentinels sniffers loopholes]
uploader = Uploader.new

sources.each do |source|
  print "Fetching #{source}..."
  raw_data = Fetcher.new(source: source).fetch
  print "#{source} data imported!\n"

  print "Processing #{source} data..."
  parser = "#{source}Parser".camelcase.constantize
  parsed_data = parser.new(data: raw_data).parse
  print "#{source} data parsed successfully!\n"

  puts "Uploading #{source} data, here it comes..."
  parsed_data.each { |data| uploader.upload(data: data) }
  puts "Uploading #{source} data completed!"
  puts "\n"
end

puts 'Uploading for all sources completed!'
