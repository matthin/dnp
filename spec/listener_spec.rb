require "spec_helper"
require "dnp/listener"

describe(Dnp::Listener) do
  context("binds to a host") do
    # Bind to any available port
    PORT = 0

    it("with an IPv4 address") do
      host = "127.0.0.1"
      listener = Dnp::Listener.new(PORT, host: host)
      expect(
        listener.instance_variable_get("@socket").addr[3]
      ).to(eq(host))
    end

    it("with an IPv6 address") do
      host = "::1"
      listener = Dnp::Listener.new(PORT, host: host)
      expect(
        listener.instance_variable_get("@socket").addr[3]
      ).to(eq(host))
    end
  end
end

