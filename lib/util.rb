
def allPages 
    all = []

    Dir.each_child(".").sort_by(&:downcase).each do | filename |
        if filename.end_with?("html")
            all << filename
        end
    end

    return all
end

def toFileName(number)
    if number < 10
        return "0" + number.to_s + ".html"
    else
        return number.to_s + ".html"
    end
end

def toPageNumber(fileName)
    return fileName.gsub(".html", "").to_i
end

def lastPageNumber()
    return toPageNumber(allPages().last)
end

def number?(str)
  return !Integer(str, exception: false).nil? 
end