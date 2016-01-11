require "fileutils"
# colorization
class String
  def red
    "\e[#{31}m#{self}\e[0m"
  end

  def green
    "\e[#{32}m#{self}\e[0m"
  end
end

puts "Copying File for Test"
#Copy file to test directory
source_qt = "Job_123442_MM30_02_01_Terms_and_terminology.mp4_5823fb160c8346bc82ec90cc4d4472b1.qt"
new_smil = "test/123442_MM30_02_01_Terms_and_terminology.smil"
new_text = 'test/123442_MM30_02_01_Terms_and_terminology.qt.text'
FileUtils.cp("examples/#{source_qt}", "test/#{source_qt}")
puts 'Copying File for Test'

puts 'Running src/main.rb on test directory'

puts '', 'Output of file:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', ''

#Run on test directory
system("ruby", "main.rb", "test/")

puts '', 'end output of file:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~', ''


puts 'Running Tests:'
successes = 0
errors = 0
#test for .qt.text file
if File.exist?("#{new_text}")
	successes += 1
	puts "Success: .qt.text file Successfully Renamed".green
else 
	errors += 1
	puts "Error: File #{new_text} not found".red
end

#test for .smil file

if File.exist?("#{new_smil}")
	successes += 1
	puts "Success: .smil file created".green
else 
	errors += 1
	puts "Error: File #{new_smil} not found".red
end

#check contents of .smil against reference

if FileUtils.identical?("examples/success.qt.text", "#{new_text}")
	successes += 1
	puts "Success: .qt.text file matches reference".green
else 
	errors += 1
	puts "Error: File test/#{new_text} not correct".red
end

#check contents of .smil against reference

if FileUtils.identical?("examples/success.smil", "#{new_smil}")
	successes += 1
	puts "Success: .smil file matches reference".green
else 
	errors += 1
	puts "Error: File test/#{new_smil} not correct".red
end

puts "#{successes} Tests Passed - #{errors} Tests Failed"

if errors == 0
	puts "No Errors, All tests passed".green
else
	puts "#{errors} Errors: Please reference above."
end

FileUtils.rm(new_text)
FileUtils.rm(new_smil)
