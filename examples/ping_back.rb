require "dnp"

Thread.new do
  listener = Dnp::Listener.new(8080)
  client = listener.accept
  client.send(client.receive)
end

client = Dnp::Client.new("127.0.0.1", 8080)
client.send("Hello!")
puts client.receive

