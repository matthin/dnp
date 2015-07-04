module Dnp
  # A server-side representation of a client. Typically is used by a server to
  # (send / receive) messages (to / from) a remote client.
  # @author Justin Harrison
  # @since 0.0.1
  # @attr [Array] buffer A buffer of the unviewed messages.
  # @attr_reader [Handle] handle Our client's handle.
  class ServerClient
    attr_accessor(:buffer)
    attr_reader(:handle)

    # The length to sleep before checking for a new received message.
    BUFFER_INTERVAL = 0.1

    # @param [Handle] handle Our client's handle.
    # @param [UDPSocket] socket Our server's socket.
    def initialize(handle, socket)
      @handle = handle
      @socket = socket
      @buffer = []
    end

    # Pops a received message from the buffer.
    # @return [String] The earliest received message.
    def receive
      loop do
        return buffer.delete_at(0) if buffer.size > 0
        sleep(BUFFER_INTERVAL)
      end
    end

    # Sends a message to the remote client.
    # @param [String] message The message to send
    def send(message)
      @socket.send(
        [message.bytesize].pack("S*"), 0, handle.host, handle.port
      )
      @socket.send(message, 0, handle.host, handle.port) if message.size > 0
      @socket.flush
    end
  end
end

