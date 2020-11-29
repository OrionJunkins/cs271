require_relative 'ACommand'
require_relative 'CCommand'
require_relative 'SymbolTable'

class Parser

  def initialize(file)
    @symbols = SymbolTable.new
    @lines = file.readlines
    clean_lines   #remove whitespace and comments from @lines 
    remove_labels #remove all labels adding to symbols table
    #Both of these functions modify @lines - see QUESTION below
  end

  def clean_lines
    @lines.map!{|line| line.gsub(/\s+/, "") }
    @lines.map!{|line| line.gsub(/\/\/[^\n]*/, "") }
    @lines.reject!{|line| line.empty?}

    ##########################################
    #QUESTION: Is it a bad idea to directly modify @lines? ie should clean_lines return a new lines array to pass on to the next step?
    ##########################################
  end

  def remove_labels
    out_lines = []
    @lines.each do |line|
      case command_type(line)
      when "A_COMMAND"      
        out_lines << line
      when "L_COMMAND"
        symbol = line.gsub(/[()]/, '')
        next_line_num = out_lines.length
        @symbols.addEntry(symbol, next_line_num)
      when "C_COMMAND"
      out_lines << line
      end
    end
    @lines = out_lines

    ##########################################
    #QUESTION: Same question, different context. This function modifies @lines. Bad practice? Copying a massive array around seems pointless and wasteful, but keeping track of the file at the all stages of parsing offers flexibility if this parser were to be extended
    ##########################################
  end

  def command_type (line)
    case line[0]
    when "@"
      type = "A_COMMAND"
    when "("
      type = "L_COMMAND"
    else
      type = "C_COMMAND"
    end

    type
  end

  def convert_line(line)
    case command_type(line)
    when "A_COMMAND"
      line = replace_symbolic_addresses(line)
      command = ACommand.new(line)
      command.binary_command
    when "L_COMMAND"
      ''
    when "C_COMMAND"
      command = CCommand.new(line)
      command.binary_command
    end

  end

  def replace_symbolic_addresses(line)
    mem_location = line[1..-1]
    if mem_location.match?(/[\D]/)  #if mem_location contains anything but ints
      mem_location = @symbols.get_address(mem_location)
    end

    line[0] + mem_location.to_s
  end

  def binary_out
    out = ""
    @lines.each do |line|
      out = out + convert_line(line)
    end

    out
  end

end
