module Dnp
  # A simple struct-like data structure which holds client information.
  # @author Justin Harrison
  # @since 0.0.1
  # @attr_reader [Integer] id The unique ID of our client.
  # @attr_reader [String] host The host address of our remote client.
  # @attr_reader [Integer] port The port of our remote client.
  class Handle
    attr_reader(:id, :host, :port)

    # @param [Integer] id The unique ID of our client.
    # @param [String] host The host address of our remote client.
    # @param [Integer] port The port of our remote client.
    def initialize(id, host, port)
      @id = id
      @host = host
      @port = port
    end
  end
end

