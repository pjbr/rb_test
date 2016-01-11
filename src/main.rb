ARGV.each do|a|
  puts "Analyizing files in Directory: #{a}"
  Dir.glob(a + '**.qt') do |file|
  	puts file
  end
end