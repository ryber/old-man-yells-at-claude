#!/usr/bin/env ruby

require "./util"

def createFile(number)
    File.write(toFileName(number), "<h1>OLD MAN YELLS AT CLAUDE</h1>")
end 

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
end 
newFile = insertAfter + 1
puts "Creating new file at #{newFile}"
createFile(newFile)