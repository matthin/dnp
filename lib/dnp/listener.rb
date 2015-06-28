require "socket"

require "dnp/handle"

module Dnp
  class Listener
    def initialize(port)
      @socket = UDPSocket.new
      @socket.bind("127.0.0.1", port)

      @handles = []

      Thread.new(read).join
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

        if id == 0
          create_client(addr[2], addr[1])
        else
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
      id = generate_id
      @socket.send([id].pack("S"), 0, host, port)
      @handles << Handle.new(id, host, port)
    end

    def generate_id
      id = rand(1..1024)
      @handles.each do |handle|
        if id == handle.id
          id = generate_id
          break
        end
      end
      id
    end
  end
end

