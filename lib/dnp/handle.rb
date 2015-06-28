module Dnp
  class Handle
    attr_reader(:id, :host, :port)

    def initialize(id, host, port)
      @id = id
      @host = host
      @port = port
    end
  end
end

