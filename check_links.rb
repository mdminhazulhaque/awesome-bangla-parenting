require 'json'
require 'net/http'
require 'uri'

DATA_FILE = '_data/parenting.json'

def check_url(url_string)
  begin
    uri = URI.parse(url_string)
  rescue URI::InvalidURIError
    puts "Invalid URI: #{url_string}"
    return false
  end

  # Handle non-HTTP/HTTPS schemes
  return false unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)

  begin
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    
    # Set timeouts to avoid hanging on bad connections
    http.open_timeout = 10
    http.read_timeout = 10

    # User-Agent is often required for sites like Google Play, Facebook, etc.
    request = Net::HTTP::Get.new(uri)
    request['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'

    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess) || response.is_a?(Net::HTTPRedirection)
      return true
    elsif response.code == '404'
      puts "Failed: #{url_string} [Status: 404 Not Found]"
      return false
    else
      # 400, 403, 401, 500, etc. - The server exists, but returned an error.
      # We shouldn't delete it automatically, as it might be bot protection or temporary.
      puts "Warning: #{url_string} [Status: #{response.code}]. Keeping it."
      return true
    end
  rescue SocketError => e
    # Domain not found or network down
    puts "Failed: #{url_string} [SocketError: #{e.message}]"
    return false
  rescue Errno::ECONNREFUSED
    puts "Failed: #{url_string} [Connection Refused]"
    return false
  rescue Net::OpenTimeout, Net::ReadTimeout
    puts "Failed: #{url_string} [Timeout]"
    return false
  rescue OpenSSL::SSL::SSLError => e
    # SSL handshake failed. The server is likely there (or a firewall).
    # We shouldn't delete because of certificate issues or local SSL config issues.
    puts "Warning: #{url_string} [SSL Error: #{e.message}]. Keeping it."
    return true
  rescue StandardError => e
    puts "Warning: #{url_string} [Unknown Error: #{e.class} - #{e.message}]. Keeping it."
    return true
  end
end

unless File.exist?(DATA_FILE)
  puts "File not found: #{DATA_FILE}"
  exit 1
end

json_data = JSON.parse(File.read(DATA_FILE))
dirty = false

json_data.each do |category, items|
  puts "Checking category: #{category}"
  current_keys = items.keys.dup
  
  current_keys.each do |name|
    url = items[name]
    print "  Checking #{name} (#{url})... "
    
    if check_url(url)
      puts "OK"
    else
      puts "REMOVING"
      items.delete(name)
      dirty = true
    end
  end
end

if dirty
  File.write(DATA_FILE, JSON.pretty_generate(json_data))
  puts "\nUpdated #{DATA_FILE} with unreachable links removed."
else
  puts "\nNo unreachable links found. #{DATA_FILE} is unchanged."
end
