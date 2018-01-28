class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    #Seed some items:
    # Item.all << Item.new("Apples", 2)
    # Item.all << Item.new("Carrots", 2)
    # Item.all << Item.new("Pears", 2)

    if req.path.match(/items/)
      item = req.path.split("/items/").last
      # resp.write "Item is #{item}\n"

      found_item = @@items.find { |i| i.name == item }

      # Item.all.each { |i| resp.write "#{i.name}\n" }

      # resp.write "Found Item is #{Item.all.find { |i| i.name == item }}\n"

      if !found_item.nil? #item was found
        resp.write "Item is #{found_item.price}"
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
