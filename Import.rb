#!/usr/bin/env ruby

require 'json'

def title(date) 
	return date.strftime('%Y-%m-%dT%H:%M')
end


if ARGV.size != 1 
	puts "Please specify a JSON file to process on the command line."
	exit(1)
end

puts "#{ARGV[0]}"

serialized = File.read(ARGV[0])
journal = JSON.parse(serialized)

journal['entries'].each { |entry|
	puts entry['creationDate'], entry['timeZone']
}
