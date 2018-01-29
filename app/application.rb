require 'pry'

class Application

  def call(env)
    req = Rack::Request.new(env)
    resp = Rack::Response.new

    if req.path.match(/\/items\/*/)
      name = req.path.split('/')[-1]
      found_item = find_item_by_name(name)

      if found_item
        resp.write("#{found_item.price}")
      else
        resp.write("Item not found")
        resp.status = 400
      end

    else
      resp.write("Route not found")
      resp.status = 404
    end
    resp.finish
  end

  def find_item_by_name(name)
    Item.all.find do |item|
      item.name == name
    end
  end

end
