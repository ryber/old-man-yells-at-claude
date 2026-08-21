require "optparse"
require_relative "lib/util.build"
require_relative "lib/util.insert"

options = {}
parser = OptionParser.new do |opts|
  opts.banner = "\nRybers Deck Builder\n"
  opts.on("-i position", "--insert position", Integer, "Insert a new slide at this position") do |n|
      options[:insert] = n
  end

  opts.on("-m", "--monitor", "Start a new monitor process that will watch the current directory and rebuild on changes") do
      options[:monitor] = true
  end

  opts.on("-b", "--build", "Build the deck") do
      options[:build] = true
  end
end

parser.parse!
puts parser.help

if options[:build]
  build()
end

if options[:monitor]
  monitor()
end

if options[:insert]&. > 0
  insertAt(options[:insert])
  build()
end



