class SymbolTable
  def initialize 
    @symbol_table = {
      "SP" => 0,
      "LCL" => 1,
      "ARG" => 2,
      "THIS" => 3,
      "THAT" => 4,
      "R0" => 0,
      "R1" => 1,
      "R2" => 2,
      "R3" => 3,
      "R4" => 4,
      "R5" => 5,
      "R6" => 6,
      "R7" => 7,
      "R8" => 8,
      "R9" => 9,
      "R10" => 10,
      "R11" => 11,
      "R12" => 12,
      "R13" => 13,
      "R14" => 14,
      "R15" => 15,
      "SCREEN" => 16384,
      "KBD" => 24576
    }
    @RAM_index = 16
  end

  def get_address(mem_location)
    unless @symbol_table.key?(mem_location)
      @symbol_table[mem_location] = @RAM_index
      @RAM_index = @RAM_index + 1
    end
    @symbol_table[mem_location]
  end
  
  def addEntry(symbol, line_num)
    @symbol_table[symbol] = line_num
  end

end
