require 'mime/types'
require 'pathname'
require 'kt-paperclip'
require 'marcel'

Paperclip.options[:log] = false

# Check if a file path is provided as a command line argument
if ARGV.length != 1
  puts "Usage: ruby script.rb path/to/your/file.extension"
  exit
end

file_path = ARGV[0]  # Get the file path from the command line argument

# Open the file
file = File.open(file_path, "rb")

# Get the MIME type
ruby_mime_type = MIME::Types.type_for(file_path).first.to_s
marcel_mime_type = Marcel::MimeType.for(file)

attachment = Paperclip.io_adapters.for(File.new(file_path))
paperclip_mime_type = attachment.content_type
file_mime_type = `file --mime -b #{file_path} | cut -d ';' -f 1`.chomp

# Output the MIME type
puts "File MIME: #{file_mime_type}"
puts "Ruby MIME: #{ruby_mime_type}"
puts "Marcel MIME: #{marcel_mime_type}"
puts "Paperclip MIME: #{paperclip_mime_type}"