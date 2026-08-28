#!/usr/bin/env ruby

require_relative "util"

def insertAt(insertAfter)
    lastPageNumber = lastPageNumber()

    puts "Inserting page after #{insertAfter}"

    if insertAfter < lastPageNumber
        puts "inserting page in the middle. Shifting pages"

        lastPageNumber.downTo(insertAfter + 1).each {
            |page| 
            newPageNumber = page + 1
            print "moving #{page} to #{newPageNumber}" 
            File.rename(toFileName(page), toFileName(newPageNumber))
            puts "...done"
        }
    end 
    newFile = insertAfter + 1
    puts "Creating new file at #{newFile}"
    File.write(toFileName(newFile), "<h1>OLD MAN YELLS AT CLAUDE</h1>")
end