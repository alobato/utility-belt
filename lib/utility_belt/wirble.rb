begin
  require "wirble"
  Wirble.init
  Wirble.colorize
rescue LoadError => e
  puts "Seems you don't have Wirble installed: #{e}"
end