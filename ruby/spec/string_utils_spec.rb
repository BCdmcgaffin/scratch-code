require File.expand_path(File.dirname(__FILE__) + '/../../../lib/utils/string_utils')

class DriverClass
  extend StringUtils
end

describe StringUtils do 
  describe "#pluralize_phrase" do
    it "should return nil if phrase is nil" do
      DriverClass.pluralize_phrase(nil, 1).should be_nil
    end

    it "should return unmodified phrase if count is nil" do
      DriverClass.pluralize_phrase("str", nil).should == "str"
    end
    
    it "should return the string unchanged if no token is found" do
      str = DriverClass.pluralize_phrase("This sentence has no variable token.", 0)
      str.should == "This sentence has no variable token."
    end
    
    it "should select the singular form when the count is singular" do
      str = DriverClass.pluralize_phrase("You have passed {{count}} out of 10 {{token||tokens}}.", 1)
      str.should == "You have passed 1 out of 10 token."
    end

    it "should select the plural form when the count is plural" do
      str = DriverClass.pluralize_phrase("You have passed {{count}} out of 10 {{token||tokens}}.", 5)
      str.should == "You have passed 5 out of 10 tokens."
    end
    
    it "should select the plural form when the count is 0" do
      str = DriverClass.pluralize_phrase("You have passed {{count}} out of 10 {{token||tokens}}.", 0)
      str.should == "You have passed 0 out of 10 tokens."
    end

    it "should accomodate multiple substitutions in the same string" do
      str = DriverClass.pluralize_phrase("The {{count}} {{dog||dogs}} ate {{count}} {{plantain||plantains}}.", 5)
      str.should == "The 5 dogs ate 5 plantains."
    end
  end
end
