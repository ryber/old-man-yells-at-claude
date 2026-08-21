require_relative "util"

def removeAt(removeAt)
    lastPageNumber = lastPageNumber()

    puts "Removing page #{removeAt}"
    File.delete(toFileName(removeAt))

    if removeAt < lastPageNumber
        puts "Shifting pages"
        startShift = removeAt + 1
        startShift.step(lastPageNumber).each {
            |page| 
            newPageNumber = page - 1
            print "moving #{page} to #{newPageNumber}" 
            File.rename(toFileName(page), toFileName(newPageNumber))
            puts "...done"
        }
    end 
end