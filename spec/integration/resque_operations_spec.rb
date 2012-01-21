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

describe "Getting queue size from Resque" do
  it "succeeds" do
    SimpleResque.clear("BuyStuff")

    expect {
      SimpleResque.push("BuyStuff")
      SimpleResque.push("BuyStuff")
    }.to change { SimpleResque.size("BuyStuff") }.from(0).to(2)
  end
end

describe "Popping jobs from Resque" do
  it "succeeds" do
    SimpleResque.clear("BuyStuff")
    SimpleResque.push("Shaz",%q(1 2 3))
    SimpleResque.pop("Shaz").should == { "class" => "Shaz", "args" => %q(1 2 3) }
  end
end

describe "Clearing a Resque queue" do
  it "succeeds" do
    Resque.push(:buy_stuff,class: "BuyStuff", args: [])
    expect { SimpleResque.clear("BuyStuff") }.to change { SimpleResque.size("BuyStuff") }.from(1).to(0)
  end
end
