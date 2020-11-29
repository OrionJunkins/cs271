require_relative 'parser'

def generate_hack(input_file_name)
  input_file = File.open(input_file_name)
  file_parser = Parser.new(input_file)
  output = file_parser.binary_out
  output_file_name = input_file_name.gsub(/\.[\w]*$/, ".hack")
  File.open(output_file_name, "w") {|out| out << output }
end

def parse_files_fromn_ARGV
  ARGV.each do|file_name|
    generate_hack(file_name)
  end
end

parse_files_fromn_ARGV
