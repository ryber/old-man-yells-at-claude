require_relative "ryber.util"
require 'fileutils' 

def stash(number)
	filename = toFileName(number)
	newName = getNewFileName(filename)
	puts "moving #{filename} to #{newName}" 
	mvFile(filename, newName)
end

def mvFile(fileName, newName)
	FileUtils.mkdir_p("stash")
	FileUtils.cp(fileName, "stash/#{newName}")
end


def getNewFileName(filename)
	title = getTitle(File.read(filename))
	return title.gsub(" ", "_") << ".html"
end