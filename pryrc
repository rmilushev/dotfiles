Pry.config.editor = 'vim'
Pry.commands.alias_command 'e', 'exit'
Pry.commands.alias_command 'q', 'exit-program'
Pry.commands.alias_command 'w', 'whereami'

if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# use awesome print for output if available
begin
  require 'awesome_print'
  Pry.config.print = proc do |output, value|
    value = value.to_a if defined?(ActiveRecord) && value.is_a?(ActiveRecord::Relation)
    output.puts value.ai
  end
rescue LoadError => err
  Pry.config.print = Pry::DEFAULT_PRINT
end

