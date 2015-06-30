require "socket"

require "dnp/server_client"
require "dnp/handle"

module Dnp
  class Listener
    def initialize(port)
      @socket = UDPSocket.new
      @socket.bind("127.0.0.1", port)

      @clients = []

      Thread.new do
        read
      end
    end

    def accept
      clients_num = @clients.length
      loop do
        break if clients_num < @clients.length
        sleep(1)
      end
      @clients[clients_num]
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
          @clients.each do |client|
            if client.handle.id == id
              client.buffer << @socket.recv(size)
            end
          end
        end
      end
    end

    def create_client(host, port)
      id = generate_id
      @socket.send([id].pack("S"), 0, host, port)

      @clients << ServerClient.new(
        Handle.new(id, host, port)
      )
    end

    def generate_id
      id = rand(1..1024)
      @clients.each do |client|
        if id == client.handle.id
          id = generate_id
          break
        end
      end
      id
    end
  end
end

