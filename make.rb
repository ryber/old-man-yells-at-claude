require "optparse"
require_relative "lib/util.build"
require_relative "lib/util.insert"
require_relative "lib/util.remove"


parser = OptionParser.new do |opts|
  opts.banner = "\nRybers Deck Builder\n"
  
  opts.on("-i position", "--insert position", Integer, "Insert a new slide at this position") do |n|     
    if n > 0
  		insertAt(n)
  		build()
	end
  end

  opts.on("-r position", "--remove position", Integer, "Remove the slide at the position and collapse the rest of the deck") do |n|
      if n > 0
		removeAt(n)
		build()
	end
  end

  opts.on("-m", "--monitor", "Start a new monitor process that will watch the current directory and rebuild on changes") do
  	monitor()
  end

  opts.on("-b", "--build", "Build the deck") do
        build()
  end
  
  opts.on("-a", "--add", "Adds a new page at the end") do
  		insertLast()
  end
  
opts.on("-o", "--open", "Open the deck in a browser") do
  		system("open", "./deck/index.html")
  end
end

parser.parse!
puts parser.help







