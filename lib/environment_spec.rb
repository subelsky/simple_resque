require "spec_helper"
require "subelsky_power_tools/environment"

describe SubelskyPowerTools::Environment do
  context "extraction of required environment variables" do
    def conduct_test(val1 = "shaz",val2 = "bot")
      ENV['_SPT_EE_TEST_VALUE1'] = val1
      ENV['_SPT_EE_TEST_VALUE2'] = val2
      SubelskyPowerTools::Environment.extract!(:'_spt_ee_test_value1',:'_spt_ee_test_value2')
    end

    it "succeeds if all specified variables are non-blank" do
      expect { conduct_test }.not_to raise_error
    end

    it "raises error if any specified variable is blank" do
      expect { conduct_test(" ","bot") }.to raise_error(RuntimeError)
    end

    it "raises error if any specified variable is zero-width" do
      expect { conduct_test("shaz","") }.to raise_error(RuntimeError)
    end

    it "raises error if any specified variable is nil" do
      expect { conduct_test("",nil) }.to raise_error(RuntimeError)
    end

    it "returns the value of the extracted variables" do
      val1, val2 = conduct_test("alpha","beta")
      val1.should == "alpha"
      val2.should == "beta"
    end
  end

  context "extraction of optional environment variables" do
    def conduct_test(val1 = "shaz",val2 = "bot")
      ENV['_SPT_EE_TEST_VALUE1'] = val1
      ENV['_SPT_EE_TEST_VALUE2'] = val2
      SubelskyPowerTools::Environment.extract(:'_spt_ee_test_value1',:'_spt_ee_test_value2')
    end

    it "succeeds if any specified variable is blank" do
      expect { conduct_test(" ","bot") }.not_to raise_error
    end

    it "succeeds if any specified variable is zero-width" do
      expect { conduct_test("shaz","") }.not_to raise_error
    end

    it "suceeds if any specified variable is nil" do
      expect { conduct_test("",nil) }.not_to raise_error
    end

    it "returns the value of the extracted variables" do
      val1, val2 = conduct_test(nil,"beta")
      val1.should == nil
      val2.should == "beta"
    end
  end
end
