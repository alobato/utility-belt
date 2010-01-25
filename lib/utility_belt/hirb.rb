begin
  require 'hirb'
  Hirb.enable :pager => false
  extend Hirb::Console
rescue LoadError => e
  puts "Install hirb!!: #{e}"
end