#!/usr/bin/env ruby

require 'json'
require 'time'
require 'fileutils'

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
	ctime = Time.parse(entry['creationDate'])
	month = ctime.strftime("%B")
	year =  ctime.year.to_s
	if entry['timeZone'] == "America/Los_Angeles"
		tstring = ctime.localtime(-7*3600).xmlschema # one-off in PDT
	else
		tstring = ctime.localtime.xmlschema
	end
	
	fname = tstring[0,16]

	fpath = "#{year}/#{month}/#{fname}.md"
	FileUtils.mkdir_p "#{year}/#{month}"

	puts "Writing #{fpath}"
	File.write(​fpath​, ​entry['text'])
}
