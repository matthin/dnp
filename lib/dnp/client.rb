require 'socket'

module Dnp
  # A end-user representation of a network client. Typically connects to a
  # server which then is paired with a ServerClient.
  # @author Justin Harrison
  # @since 0.0.1
  class Client
    # param [String] host The remote host address which is being connected too.
    # param [Integer] port The port which the remote server is listening on.
    def initialize(host, port)
      @socket = UDPSocket.new
      @socket.connect(host, port)

      @id = 0
      # The server will initialize our client if we send an id of 0.
      send('')

      @id = @socket.recv(2).unpack('S')[0].to_i
    end

    # Sends a message to the remote server.
    # #param [String] message The message to send.
    def send(message)
      @socket.send(
        [message.bytesize, @id].pack('S*'), 0
      )
      @socket.send(message, 0) if message.size > 0
      @socket.flush
    end

    # Receive a message from the remote server.
    # @return [String] The received message.
    def receive
      header = @socket.recv(2)
      size = header.unpack('S')[0].to_i
      @socket.recv(size)
    end
  end
end

