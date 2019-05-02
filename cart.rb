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
endclass Cart

  attr_reader :items

  include ItemContainer
  class ItemNotSupported < StandardError; end

  UNSUPPORTED_ITEMS = [AntiqueItem, VirtualItem]

  def initialize(owner)
    @items = Array.new
    @owner = owner
  end

  def add_items(*items)
    @items += items
  end

  def save_to_file
    File.open("#{@owner}_cart.txt","w") do |f|
      @items.each do |i|
        raise ItemNotSupported if UNSUPPORTED_ITEMS.include?(i.class)
        f.puts i
      end
    end
  end

  def read_from_file
    File.readlines("#{@owner}_cart.txt").each {|i| @items << i.to_real_item}
    @items.uniq! # deletes same elements
  rescue Errno::ENOENT
    File.open("#{@owner}_cart.txt", "w") {}
    puts "file #{@owner}_cart.txt created"
  end

end
