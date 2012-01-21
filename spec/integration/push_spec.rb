require "spec_helper"
require "simple_resque"

describe "Pushing a job to Resque" do
  it "suceeds" do
    expect {
      SimpleResque.push("TransformVehicle",[5, "autobot"])
    }.to change { Resque.size(:transform_vehicle) }.from(0).to(1)

    job = Resque.pop(:transform_vehicle)
    job["class"].should == "TransformVehicle"
    job["args"].should == [5,"autobot"]
  end
end
