module Dnp
  class ServerClient
    attr_accessor(:buffer)
    attr_reader(:handle)

    BUFFER_INTERVAL = 0.1

    def initialize(handle, socket)
      @handle = handle
      @socket = socket
      @buffer = []
    end

    def receive
      loop do
        return buffer.delete_at(0) if buffer.size > 0
        sleep(BUFFER_INTERVAL)
      end
    end

    def send(message)
      @socket.send(
        [message.bytesize].pack("S*"), 0, handle.host, handle.port
      )
      @socket.send(message, 0, handle.host, handle.port) if message.size > 0
      @socket.flush
    end
  end
end

