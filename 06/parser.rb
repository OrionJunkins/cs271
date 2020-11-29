require_relative 'ACommand'
require_relative 'CCommand'
require_relative 'SymbolTable'

class Parser

  attr_accessor :lines, :cur_line_num

  def initialize(file)
    @symbols = SymbolTable.new
    @lines = file.readlines
    clean_lines #remove whitespace and comments from @lines 
    remove_labels #remove all labels adding to symbols
  end

  def clean_lines
    #bad idea to directly modify @lines?
    @lines.map!{|line| line.gsub(/\s+/, "") }
    @lines.map!{|line| line.gsub(/\/\/[^\n]*/, "") }
    @lines.reject!{|line| line.empty?}
  end

  def remove_labels
      #bad idea to directly modify @lines?
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

  def symbol
    pass #?
  end

  def convert_line(line)
    case command_type(line)
    when "A_COMMAND"
      mem_location = line[1..-1]
      if mem_location.match?(/[\D]/)  #if mem_location contains anything but ints
        mem_location = @symbols.get_address(mem_location)
        line = line[0] + mem_location.to_s
      end
      com = ACommand.new(line)
      com.bin_command
    when "L_COMMAND"
      ''
    when "C_COMMAND"
      com = CCommand.new(line)
      com.bin_command
    end
  end


  def binary_out
    out = ""
    lines.each do |line|
      out = out + convert_line(line)
    end
    out
  end
end





