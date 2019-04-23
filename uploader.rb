# frozen_string_literal: true

# Upload parsed data to server
class Uploader
  include RequestCommon
  ALLOWED_NODES = %w[alpha beta gamma delta theta lambda tau psi omega].freeze

  def upload(data:)
    unless ALLOWED_NODES.include?(data[:start_node])
      return puts "Not allowed node: #{data[:start_node]}; Uploding interrupted"
    end

    data[:passphrase] = PASSPHRASE
    puts "result for #{data}"
    http = Curl.post(BASE_URL, data)
    puts "code: #{http.response_code}; #{http.body_str}"
  end
end
