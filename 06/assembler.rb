require_relative 'parser'

def produce_hack(input_file_name)
  input_file = File.open(input_file_name)
  file_parser = Parser.new(input_file)
  output = file_parser.binary_out
  output_file_name = input_file_name.gsub(/\.[\w]*$/, ".hack")
  
  #puts output_file_name
  File.open(output_file_name, "w") {|out| out << output }
end

def main
  ARGV.each do|file_name|
    produce_hack(file_name)
  end
end

main


