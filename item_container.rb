module ItemContainer

  module ClassMethods

    # expexted that item's price linked on dollar course
    def min_price
      100 # connect to the internet and receive currency price
    end

  end

  module InstanceMethods

    attr_reader :items

    def method_missing(method_name)
      if method_name =~ /^all_/
        # puts "showing all items"
        show_all_items_with_name(method_name.to_s.sub(/^all_/,'').chomp('s'))
      else
        # puts "method #{method_name} is not defined on this object"
        super
      end
    end

    def add_item item
      unless item.price< self.class.min_price
        @items.push item
      end
    end

    # removes last item
    def remove_item
      @items.pop
    end

    def validate
      @items.each { |i| puts "Item has no price" if i.price.nil?}
    end

    def delete_invalid_items
      @items.delete_if { |i| i.price.nil? }
    end

    def count_valid_items
      @items.count { |i| i.price } # count true where item have price
    end

    private

      def show_all_items_with_name(n)
        @items.map { |i| i if n == i.name}.delete_if { |i| i.nil?}
      end

  end

  # this method named callback, its calls every time when class include ItemContainer
  def self.included(base) # in argument holds class in which putting module
    base.extend ClassMethods
    base.class_eval do
      include InstanceMethods
    end
  end

end
