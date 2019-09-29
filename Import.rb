#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'open-uri'

def title(date) 
	return date.strftime('%Y-%m-%dT%H:%M')
end

def UlSend(action, params)
	uri = URI("ulysses://x-callback-url/#{action}?" + URI.encode_www_form(params))
	puts uri.to_s
	URI.parse(uri).open { |f|
		puts f.uri
		puts f.code
	}
end

def UlNewSheet(text)
	UlSend("new-sheet", { :text => URI.encode(text) })
end

UlNewSheet('This is a new sheet from Ruby')
