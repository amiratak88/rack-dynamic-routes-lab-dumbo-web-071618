class Application
    
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            i = req.path.split("/items/").last
            find = Item.all.find do |item|
                item.name == i
            end
            if find.nil?
                resp.write "Item not found"
                resp.status = 400
            else
                resp.write "#{find.price}"
            end
        else
            resp.status = 404
            resp.write "Route not found"
        end
        resp.finish
    end
end