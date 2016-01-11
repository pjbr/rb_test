# General comment: The code would be more readable and maintainable if it was broken up into functions

# Variable name is misleading, this is a timestamp regex, not caption
caption_reg = /\[\d+:\d+:\d+.\d+\]/
caption_drop_reg = /^\s*\{BLANK\_AUDIO\}\s*$/

ARGV.each do |path|
  puts "Analyizing files in Directory: #{path}"
  counter = 0
  # The files will have different GUIDs after mp4: *.mp4_*.qt
  Dir.glob(path + '*.mp4_5823fb160c8346bc82ec90cc4d4472b1.qt') do |qt_file|
    counter += 1
    content = Array.new
    caption_block = Array.new
    in_caption = false
    File.open(qt_file, "r") do |f|
      f.each_line do |line|
        #check to see if line is timestamp
        if caption_reg.match(line)
          #If not in caption push caption to 
          if !in_caption
            caption_block.push(line)
            in_caption = true
          else 
            #do not push ending timestamp
            caption = caption_block[1..-1].join('')
            #do not include caption or timestamp if [BLANK_AUDIO]
            unless caption_drop_reg.match(caption)
              content.concat caption_block
            end
            caption_block = []
            in_caption = false
          end
        elsif in_caption==true

          # The spec asked for parenthesis () not curly braces
          caption_block.push(line.gsub(/[\[\]]/, '[' => '{', ']' => '}'))
        else 
          content.push(line)
        end
      end
    end
    #it would be safer to not overwrite the input files.
    #What if the script makes a mistakes and you destroy your originals?
    #write contents over file
    File.open(qt_file, "w") do |f|
      f.puts content
    end
    # File is closed automatically at end of block
    #Rename the .qt file to file.
    filename = File.basename(qt_file, '.mp4_5823fb160c8346bc82ec90cc4d4472b1.qt')[4..-1]
    File.rename(qt_file, "#{path+filename}.qt.text")

    # You didn't want to use string substitution?
    # Reading the text from the file would make the script more flexable. (We could change the SMIL file as needed)
    #Create a smil
    smil = File.new("#{path+filename}.smil", "w")
    smil.puts '<?xml version="1.0" encoding="UTF-8"?>'
    smil.puts '<smil xmlns:qt="http://www.apple.com/quicktime/resources/smilextensions"'
    smil.puts '   xmlns="http://www.w3.org/TR/REC-smil" qt:time-slider="true" qt:autoplay="true">'
    smil.puts ' <head>'
    smil.puts '  <meta name="title" content=""/>'
    smil.puts '  <meta name="author" content=""/>'
    smil.puts '  <meta name="copyright" content=""/>'
    smil.puts '  <layout>'
    smil.puts '   <root-layout height="612" width="960" background-color="black"/>'
    smil.puts '   <region height="540" width="960" background-color="black" left="0"'
    smil.puts '      top="0" id="videoregion"/>'
    smil.puts '   <region height="52" width="960" background-color="#000000" left="0"'
    smil.puts '      top="540" id="textregion"/>'
    smil.puts '    </layout>'
    smil.puts '  </head>'
    smil.puts '  <body>'
    smil.puts '    <par>'
    smil.puts '      <video region="videoregion" src="' + filename + '.mov" region="video" />'
    smil.puts '      <textstream region="textregion" src="' +filename + '.qt.txt" region="text" />'
    smil.puts '    </par>'
    smil.puts '  </body>'
    smil.puts '</smil>'
    smil.close

  end
  puts "#{counter} files processed"
end
