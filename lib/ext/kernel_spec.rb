require "spec_helper"
require "subelsky_power_tools/ext/kernel"

describe "Kernel#retryable" do
  it "retries exceptions for the specified number of times" do
    count = 0

    begin
      retryable(tries: 3) do
        count += 1
        raise ArgumentError
      end
    rescue ArgumentError
    end

    count.should == 3
  end

  it "reraises exceptions after exhausting all tries" do
    expect {
      retryable(tries: 2) { raise ArgumentError }
    }.to raise_error(ArgumentError)
  end

  it "waits specified number of seconds between tries" do
    # this seems like a better way to measure sleep than using the clock
    Kernel.should_receive(:sleep).with(0.2).exactly(2).times

    begin
      retryable(tries: 3,sleep: 0.2) { raise ArgumentError }
    rescue ArgumentError
    end

  end

  it "only retries given exceptions" do
    expect {
      retryable(tries: 2,on: ScriptError) { raise ZeroDivisionError }
    }.to raise_error(ZeroDivisionError)
  end

  it "returns result of operation if it ultimately succeeds" do
    result = retryable do
      49
    end

    result.should == 49
  end

end
