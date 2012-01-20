require "spec_helper"
require "subelsky_power_tools/ext/hash"

describe Hash do

  let(:h) do
    { :a => 1, :b => 2, :c => 3 }
  end

  it "should except given keys" do
    h.except(:a).should == { :b => 2, :c => 3 }
    h.except(:a,:c).should == { :b => 2 }
  end

  it "should perform destructive exceptions" do
    h.except!(:c).should == { :c => 3 }
    h.should == { :a => 1, :b => 2 }
    h.except!(:a,:b)
    h.should be_empty
  end

  it "should include given keys only" do
    h.only(:a,:b).should == { :a => 1, :b => 2 }
  end

  it "should perform destructive inclusion" do
    h.only!(:c).should == { :a => 1, :b => 2}
    h.should == { :c => 3 }
  end
end
