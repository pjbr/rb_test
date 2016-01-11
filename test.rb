require 'fileutils'
# colorization
class String
  def red
    "\e[#{31}m#{self}\e[0m"
  end

  def green
    "\e[#{32}m#{self}\e[0m"
  end
end

puts 'Copying File for Test'

test_qt = 'Job_123442_MM30_02_01_Terms_and_terminology.mp4_5823fb160c8346bc82ec90cc4d4472b1.qt'
FileUtils.cp('examples/' + test_qt, 'test/' + test_qt)
puts 'Copying File for Test'

puts 'Running src/main.rb on test directory'

puts '', 'Output of file:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', ''
#Run on test directory
system("ruby", "./src/main.rb", "test/")

puts '', 'end output of file:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', ''


puts 'Running Tests:'
if File.exist?('test/123442_MM30_02_01_Terms_and_terminology.qt.text')
	puts 'Success: File Successfully Renamed'.green
else 
	puts 'Error: File test/123442_MM30_02_01_Terms_and_terminology.qt.text not found'.red
end
