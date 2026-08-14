#!/usr/bin/env ruby
require "digest"

def pageNumber(page)
    return page.gsub(".html", "").to_i
end

def allPages 
    all = []

    Dir.each_child(".").sort_by(&:downcase).each do | filename |
        if filename.end_with?("html")
            all << filename
        end
    end

    return all
end

def pageFile(number)
    if number < 10
        return "0" + number.to_s + ".html"
    else
        return number.to_s + ".html"
    end
end


def fixLinks(filename, content, last)
    finalString = content
    pageNumber = filename.gsub(".html", "").to_i
    if (filename != last)
        nextPage = pageNumber + 1
        finalString = finalString.gsub("Next &gt;", "<a href=\"" + pageFile(nextPage) + "\">Next</a>")
    else
        finalString = finalString.gsub("Next &gt;", "")
    end

    if pageNumber != 1
        previousPage = pageNumber -1
        finalString = finalString.gsub("Previous &lt;", "<a href=\"" + pageFile(previousPage) + "\">Previous</a>")
    else
        finalString = finalString.gsub("Previous &lt;", "")
    end    

    return finalString
end    

def render
    header = File.read("./includes/header.html")
    footer = File.read("./includes/footer.html")
    all = allPages()
    last = all.last
    allPages().each do | filename |
        rendered = header + File.read(filename) + footer
        content = fixLinks(filename, rendered, last)
        File.write("deck/"+filename, content)
        puts "done "  + filename
    end
end

def state(dir)
  entries = Dir.children(dir).sort.map do |name|
    stat = File.stat(File.join(dir, name))
    "#{name}:#{stat.size}:#{stat.mtime.to_i}"
  end
  return Digest::MD5.hexdigest(entries.join("\n"))
end


def monitor()
    target = "."

    last_state = state(target)
    puts "Watching directory: #{target}"

    loop do
        current_state = state(target)

        if current_state != last_state
            puts "Change detected."
            render()
            last_state = current_state
        end

        sleep 2
    end
end

render()
monitor()

