require "socket"

require "dnp/server_client"
require "dnp/handle"

module Dnp
  # Listens on a specific port and optional host.
  # @author Justin Harrison
  # @since 0.0.1
  class Listener
    # The length to sleep before checking for a new client.
    ACCEPT_INTERVAL = 0.1

    # @param [Integer] port The port which will be bound to.
    # @param [String] host The host will be bound to.
    def initialize(port, host: "127.0.0.1")
      if host.include?("::")
        @socket = UDPSocket.new(Socket::AF_INET6)
      else
        @socket = UDPSocket.new
      end
      @socket.bind(host, port)

      @clients = []

      Thread.new do
        read
      end
    end

    # Accepts new incomming clients.
    # @since 0.0.1
    # @return [ServerClient] Any available client on the stack.
    #
    #   client = listener.accept
    #   client.send("Testing!")
    def accept
      clients_num = @clients.length
      loop do
        break if clients_num < @clients.length
        sleep(ACCEPT_INTERVAL)
      end
      @clients[clients_num]
    end

  private
    # Handles all incomming data an the bound port.
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

    # Initializes a new server-side representation of a network client.
    # @param [String] host The host address of the remote client.
    # @param [Integer] port The port of the remote client.
    def create_client(host, port)
      id = generate_id
      @socket.send([id].pack("S"), 0, host, port)

      @clients << ServerClient.new(
        Handle.new(id, host, port), @socket
      )
    end

    # Randomly generates a unique id for keeping track of clients.
    # @return [Integer] A unique ID.
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

