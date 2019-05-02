class Order

  attr_reader :items, :placed_at, :time_spent_on_sending_email # getter

  include ItemContainer

  def initialize
    @items = [] # equals Array.new
    # ...
  end

  def place
  	@placed_at = Time.now
    thr = Thread.new do
	  Pony.mail({:to => StoreApplication::Admin.email,
	   :from => "My Store <jason.binwood@gmail.com>",
	   :via => :smtp, :via_options => {
	     :address        => 'smtp.gmail.com',
	     :port           => '3000',
	     :user_name      => 'jason.binwood@gmail.com',
	     :password       => '6bh5snql83d8',
	     :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
	     :domain         => "mail.google.com" # the HELO domain provided by the client to the server
	   },
	   subject: "New order has been placed",
	   body: "Please check back you admin page to see it!"
	  })
	end
	while(thr.alive?)
	  puts "."
	  sleep(1)
	end
	sent_email_at = Time.now
	@time_spent_on_sending_email = sent_email_at - @placed_at
  end

end
