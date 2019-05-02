require_relative "init.rb"

cart = Cart.new(ARGV.delete_at(0)) # delete_at - removes element and return it
ARGV.each do |a|
  @items.each { |i| cart.add_item(i) if a == i.name}
end

cart.read_from_file
begin
  cart.save_to_file
rescue Cart::ItemNotSupported
  puts "One the items your're trying to save is not supported by the Cart. Unsupported class are: #{Cart::UNSUPPORTED_ITEMS}"
end
