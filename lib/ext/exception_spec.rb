require "spec_helper"
require "subelsky_power_tools/ext/exception"

describe Exception do
  it "reports details" do
    begin
      raise StandardError.new("something bad happened")
    rescue StandardError => e
      e.detail.should =~ /StandardError: something bad happened\n/
    end
  end
end
