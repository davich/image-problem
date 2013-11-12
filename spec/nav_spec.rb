require 'spec_helper'

describe Nav do
  describe "index_nav" do
    it "should create the nav array" do
      Nav.index_nav(["abc", "def"]).should == [["abc", "makes/abc.html"], ["def", "makes/def.html"]]
    end
  end
  describe "makes_nav" do
    it "should add index to the start of the nav" do
      Nav.makes_nav(["abc", "def"]).should == 
        [["Index", "../index.html"], ["abc", "../models/abc.html"], ["def", "../models/def.html"]]
    end
  end
  describe "models_nav" do
    it "should create the nav array" do
      Nav.models_nav("abc").should == [["Index", "../index.html"], ["abc", "../makes/abc.html"]]
    end
  end
end