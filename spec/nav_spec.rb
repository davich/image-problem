require 'spec_helper'

describe Nav do
  describe "index_links" do
    it "should create and sort the nav array" do
      Nav.index_links(["def", "abc"]).should == [["abc", "makes/abc.html"], ["def", "makes/def.html"]]
    end
  end
  describe "make_links" do
    it "should create and sort the nav array" do
      result = Nav.make_links(["def", "abc"])
      result.index(["abc", "../models/abc.html"]).should be < result.index(["def", "../models/def.html"])
    end
    it "should add index to the start of the nav" do
      Nav.make_links(["abc", "def"]).should == 
        [["Index", "../index.html"], ["abc", "../models/abc.html"], ["def", "../models/def.html"]]
    end
  end
  describe "model_links" do
    it "should create the nav array" do
      Nav.model_links("abc").should == [["Index", "../index.html"], ["abc", "../makes/abc.html"]]
    end
  end
end