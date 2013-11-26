require 'uri'
require 'json'

module Billy
  module ResourceUtils

    def format_url(url, include_params=false)
      url = URI(url)
      url_fragment = url.fragment
      formatted_url = url.scheme+'://'+url.host+url.path
      if include_params
        formatted_url += '?'+url.query if url.query
        formatted_url += '#'+url_fragment if url_fragment
      end
      formatted_url
    end

    def json?(value)
      JSON.parse(value)
    rescue
      false
    end

    def sort_hash(hash)
      Hash[
          hash.each do |k,v|
            hash[k] = sort_hash(v) if v.class == Hash
            hash[k] = v.collect {|a| sort_hash(a)} if v.class == Array
          end.sort()
      ]
    end

    def sort_json(json_str)
      sort_hash(JSON.parse(json_str, symbolize_names: true)).to_json
    end
  end
end