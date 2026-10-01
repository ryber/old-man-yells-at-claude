require_relative "ryber.util"


def stash(number)
	mvFile(toFileName(number))
end

def mvFile(fileName)
	target_dir = 'stash'
	FileUtils.mkdir_p(target_dir)
	FileUtils.cp(fileName, target_dir)
end