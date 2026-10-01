require_relative "ryber.util"
require 'fileutils' 

def stash(number)
    puts "moving " << number
	fullname = toFileName(number)
	puts "moving " << fullname
	mvFile(fullname)
end

def mvFile(fileName)
	target_dir = 'stash'
	FileUtils.mkdir_p(target_dir)
	FileUtils.cp(fileName, target_dir)
end