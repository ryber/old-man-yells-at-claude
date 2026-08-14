#!/usr/bin/env ruby

require "./util"

lastPageNumber = lastPageNumber()
insertAfter = lastPageNumber
if !ARGV.empty? && number?(ARGV[0])
    insertAfter = ARGV[0].to_i
end

puts "Inserting page after #{insertAfter}"

if insertAfter < lastPageNumber
    puts "inserting page in the middle. Shifting pages"

    lastPageNumber.downto(insertAfter + 1).each {
        |page| 
        newPageNumber = page + 1
        print "moving #{page} to #{newPageNumber}" 
        File.rename(toFileName(page), toFileName(newPageNumber))
        puts "...done"
    }
    File.write(toFileName(insertAfter + 1), "<h1>OLD MAN YELLS AT CLAUDE</h1>")
end
