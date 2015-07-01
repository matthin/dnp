require "spec_helper"
require "dnp/listener"

require "dnp/server_client"

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

  it("binds to a port") do
    listener = Dnp::Listener.new(PORT)
    expect(
      listener.instance_variable_get("@socket").addr[1]
    ).to(be_a(Integer))
  end

  it("accepts a new client") do
    listener = Dnp::Listener.new(PORT)
    server_client = double(Dnp::ServerClient)


    accept_thread = Thread.new do
      expect(
        listener.accept
      ).to(eq(server_client))
    end

    sleep(0.01)
    listener.instance_variable_set("@clients", [server_client])

    accept_thread.join
  end
end

