require_relative "ryber.util"
require 'fileutils' 

def stash(number)
	filename = toFileName(number)
	newName = getTitle(File.read(filename))
	puts "moving #{filename} to #{newName}" 
	mvFile(filename)
end

def mvFile(fileName)
	target_dir = 'stash'
	FileUtils.mkdir_p(target_dir)
	FileUtils.cp(fileName, target_dir)
end