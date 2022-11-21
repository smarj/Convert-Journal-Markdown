#!/usr/bin/env ruby

require 'fileutils'
include FileUtils::Verbose

# read in all *.md files in the current directory   
contents =  lastdate = ""
files = Dir.glob("*.md").sort.each { |f|
    # Get the date from the filename
    md = /(\d{4}-\d{2}-\d{2})T/.match(f)
    if md == nil
        next
    end
    date = md[1]
    if date != lastdate && contents != ""
        fh = File.open("#{lastdate}.md", "w")
        fh.write(contents)
        fh.close
        contents = ""
    end
    
    contents << "\n" << File.open(f).read.gsub(".#meeting", "#meeting").gsub("# multitasking", "#multitasking")
    lastdate = date
    mv(f, "archive/#{f}")
}

# write out the last file
fh = File.open("#{lastdate}.md", "w")
fh.write(contents)
fh.close
