require_relative "store_application"

StoreApplication.config do |app|

  app.name        = "My Store"
  app.environment = :production

  app.admin do |admin|
    admin.email = "admin@mystore.com"
    admin.login = "admin"
    admin.send_info_emails_on :mondays
  end

end

@items = []
@items << AntiqueItem.new("car", :price => 101, :weight =>100)
@items << RealItem.new(weight:100, price: 101, name:"kettle")
@items << RealItem.new({ :weight =>100, :price => 101, :name => "dishwasher" })

order = Order.new
order.place
puts order.placed_at.utc
puts order.time_spent_on_sending_email
puts order.placed_at.strftime("%b %-d, %Y %H:%M:%S") # Jan 1, 1970 15:00:00
