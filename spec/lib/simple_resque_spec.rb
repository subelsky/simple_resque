require "spec_helper"
require "simple_resque"

describe SimpleResque do
  let(:resque_stub) { stub("resque") }

  before { SimpleResque.resque = resque_stub }

  it "creates a proper push request from the given parameters" do
    resque_stub.should_receive(:push).with("transmogrifier",class: "Transmogrifier",args: [{ id: 3, state: "back_to_calvin" }])
    SimpleResque.push("Transmogrifier",id: 3, state: "back_to_calvin")
  end

  it "returns the size of a given resque queue" do
    resque_stub.should_receive(:size).with("count_score").and_return(3)
    SimpleResque.size("CountScore").should == 3
  end

  it "pops the top off a given resque queue" do
    data = { class: "GenerateFireball", args: [:a, :b] }
    resque_stub.should_receive(:pop).with("generate_fireball").and_return(data)
    SimpleResque.pop("GenerateFireball").should == data
  end

  it "clears the queue" do
    resque_stub.should_receive(:remove_queue).with("howitzer")
    SimpleResque.clear("Howitzer")
  end
end
