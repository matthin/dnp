require "spec_helper"
require "dnp/handle"

describe(Dnp::Handle) do
  it("initializes fields") do
    # Can't use constants in tests since they are bound by module, not file.
    id = 87
    host = "127.0.0.1"
    port = 8081
    handle = Dnp::Handle.new(id, host, port)
    expect(handle.id).to(eq(id))
    expect(handle.host).to(eq(host))
    expect(handle.port).to(eq(port))
  end
end

