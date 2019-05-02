class RealItem < Item

  attr_reader :weight

  show_info_about :weigth, lambda { |attr| attr > 5}

  def initialize(options)
    @weight = options[:weight]
    super(options[:name],options)
  end


  def info
    # если у ключа нет значения или если в значении ключа weight has block which results in true then next line (true branch)
    if !@@show_info_about[:weight] ||
      @@show_info_about[:weight].call(weight)
      yield weight
    end
    super
  end

  def to_s
  	super + ":#{self.weight}"
  end

end
