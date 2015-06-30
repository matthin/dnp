module Dnp
  class ServerClient
    attr_accessor(:buffer)
    attr_reader(:handle)

    def initialize(handle)
      @handle = handle
      @buffer = []
    end

    def receive
      loop do
        return buffer.delete_at(0) if buffer.size > 0
        sleep(0.1)
      end
    end
  end
end

