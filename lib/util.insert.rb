#!/usr/bin/env ruby

require_relative "util"

def insertAt(insertAfter)
    lastPageNumber = lastPageNumber()

    log("Inserting page after #{insertAfter}")

    if insertAfter < lastPageNumber
        log("inserting page in the middle. Shifting pages")

        lastPageNumber.downto(insertAfter + 1).each {
            |page| 
            newPageNumber = page + 1
            log("moving #{page} to #{newPageNumber}")
            File.rename(toFileName(page), toFileName(newPageNumber))
            log("...done")
        }
    end 
    newFile = insertAfter + 1
    log("Creating new file at #{newFile}")
    File.write(toFileName(newFile), "<h1>OLD MAN YELLS AT CLAUDE</h1>")
end

def insertLast()
	insertAt(lastPageNumber())
end