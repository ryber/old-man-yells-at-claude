#!/usr/bin/env ruby
require "digest"
require_relative "util"

def fixLinks(filename, content, last)
    finalString = content
    pageNumber = toPageNumber(filename)
    if (filename != last)
        nextPage = pageNumber + 1
        finalString = finalString.gsub("Next &gt;", "<a href=\"" + toFileName(nextPage) + "\">Next</a>")
    else
        finalString = finalString.gsub("Next &gt;", "")
    end

    if pageNumber != 1
        previousPage = pageNumber -1
        finalString = finalString.gsub("Previous &lt;", "<a href=\"" + toFileName(previousPage) + "\">Previous</a>")
    else
        finalString = finalString.gsub("Previous &lt;", "")
    end    

    return finalString
end    

def build
    header = File.read("./includes/header.html")
    footer = File.read("./includes/footer.html")
    Dir.mkdir("deck") unless Dir.exist?("deck")
    all = allPages()
    last = all.last
    allPages().each do | filename |
        rendered = header + File.read(filename) + footer
        content = fixLinks(filename, rendered, last)
        File.write("deck/"+filename, content)
        
        title = getTitle(content)
        puts "done #{filename} #{title}"
    end
    buildIndex()
end

def state(dir)
  entries = Dir.children(dir).sort.map do |name|
    stat = File.stat(File.join(dir, name))
    "#{name}:#{stat.size}:#{stat.mtime.to_i}"
  end
  return Digest::MD5.hexdigest(entries.join("\n"))
end


def monitor
    target = "."

    last_state = state(target)
    puts "Watching directory: #{target}"

    loop do
        current_state = state(target)

        if current_state != last_state
            puts "Change detected. " + Time.now.to_s
            build()
            last_state = current_state
            puts "done"
        end

        sleep 2
    end
end

def getTitle(content)
	if (match = content.match(%r{<h1\b[^>]*>(.*?)</h1>}m))
  		content = match[1]
  		return content
	end
	
	return " unknown "
end

def buildIndex
	all = allPages()
	body = "<ol>"
	allPages().each do | filename |
		page = File.read(filename)
        title = getTitle(page)
        body << "<li><a href=\"#{filename} \">#{filename} (#{title})<//a><//li>"
    end
    
    header = File.read("./includes/header.html")
    footer = File.read("./includes/footer.html")
    
    File.write("deck/index.html", header << body << "</ol>" << footer)
    puts "done index"
	
end
