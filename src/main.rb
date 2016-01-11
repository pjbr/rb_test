ARGV.each do |path|
  puts "Analyizing files in Directory: #{path}"
  counter = 0
  Dir.glob(path + '*.qt') do |qt_file|
  	counter += 1
  	filename = File.basename(qt_file, '.mp4_5823fb160c8346bc82ec90cc4d4472b1.qt')[4..-1]
    File.rename(qt_file, "#{path+filename}.qt.text")
    smil = File.new("#{path+filename}.smil", "w")
    smil.puts 'Success'
  end
  puts "#{counter} files processed"
end