require "socket"

module Dnp
  class Client
    attr_accessor(:handle)

    def initialize(host, port)
      @socket = UDPSocket.new
      @socket.bind("127.0.0.1", 8081)
      @socket.connect(host, port)
      @id = 0

      # The server will initialize our client if it receives no message.
      send("")

      @id = @socket.recv(2).to_i
    end

    def send(message)
      @socket.send(
        [message.bytesize, @id].pack("S*"), 0
      )
      #@socket.send(
      #  message, 0
      #)
    end

    def receive
      @socket.recv(20)
    end
  end
end

