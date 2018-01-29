class Application


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      if Item.all.map{|item| item.name}.include?(item_name)
        resp.write display_price(item_name)
      else
        resp.write "Item not found"
        resp.status = 400
      end

    else
      resp.write "Route not found"
      resp.status = 404
    end
    #resp.status = 400
    resp.finish
  end


  def display_price(item_name)
      found_item = Item.all.find{|item| item.name == item_name }
      return found_item.price
  end


end
