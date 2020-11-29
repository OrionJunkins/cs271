class ACommand

  def initialize (command)
    @in_command = command
  end
  
  def bin_command 
    line_num_dec = @in_command[1..-1].to_i
    line_num_bin = line_num_dec.to_s(2)
    num_leading_zeros = 16 - line_num_bin.size
    leading_zeros = "0" * num_leading_zeros
    leading_zeros + line_num_bin + "\n"
  end


end

