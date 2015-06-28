require "socket"

require "dnp/handle"

module Dnp
  class Server
    def initialize(port)
      @socket = UDPSocket.new
      @socket.bind("127.0.0.1", port)

      @handles = []

      read
    end

    def accept
      message, addr = @socket.recvfrom(2)
      message = message.unpack("S")
      puts message
    end

  private
    def read
      loop do
        header, addr = @socket.recvfrom(4)
        size = header.unpack("S")[0].to_i
        id = header.unpack("S*")[1].to_i

        if size == 0
          create_client(addr[2], addr[1])
        end

        unless id == 0
          @handles.each do |handle|
            if handle.id == id
              @socket.send(
                "Testing123",
                0,
                handle.host,
                handle.port
              )
            end
          end
        end
      end
    end

    def create_client(host, port)
      @socket.send(67.to_s, 0, host, port)
      @handles << Handle.new(67, host, port)
    end
  end
end

