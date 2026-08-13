
header = File.read("./includes/header.html")
footer = File.read("./includes/footer.html")

Dir.each_child(".").sort_by(&:downcase).each do | filename |
    if filename.end_with?("html")
        content = header + File.read(filename) + footer
        File.write("deck/"+filename, content)
        puts "done "  + filename
    end
end