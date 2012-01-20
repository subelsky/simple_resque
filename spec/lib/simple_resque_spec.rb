require "spec_helper"
require "simple_resque"

describe SimpleResque do
  let(:resque_stub) { stub("resque",push: nil) }

  before { SimpleResque.resque = resque_stub }

  it "creates a proper push request from the given parameters" do
    resque_stub.should_receive(:push).with("transmogrifier",class: "Transmogrifier",args: { id: 3, state: "back_to_calvin" })
    SimpleResque.push("Transmogrifier",id: 3, state: "back_to_calvin")
  end
end
