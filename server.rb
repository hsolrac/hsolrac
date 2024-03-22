require_relative './lib/solrac.rb'

app = Solrac.new

app.get("/") do
  "Hello World"
end

app.listen(3000)
