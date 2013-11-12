require 'spec_helper'

describe Nav do
  before do
    @nav = Nav.new("output/")
  end
  describe "index_links" do
    it "should create and sort the nav array" do
      @nav.index_links(["def", "abc"]).should == [["abc", "makes/abc.html"], ["def", "makes/def.html"]]
    end
    it "should sanitize filenames" do
      @nav.index_links([" N&1k;;"])[0].should == [" N&1k;;", "makes/_n_1k_.html"]
    end
  end
  describe "make_links" do
    it "should create and sort the nav array" do
      result = @nav.make_links(["def", "abc"])
      result.index(["abc", "../models/abc.html"]).should be < result.index(["def", "../models/def.html"])
    end
    it "should add index to the start of the nav" do
      @nav.make_links(["abc", "def"]).should == 
        [["Index", "../index.html"], ["abc", "../models/abc.html"], ["def", "../models/def.html"]]
    end
    it "should sanitize filenames" do
      @nav.make_links([" N&1k;;"])[1].should == [" N&1k;;", "../models/_n_1k_.html"]
    end
  end
  describe "model_links" do
    it "should create the nav array" do
      @nav.model_links("abc").should == [["Index", "../index.html"], ["abc", "../makes/abc.html"]]
    end
    it "should sanitize filenames" do
      @nav.model_links(" N&1k;;")[1].should == [" N&1k;;", "../makes/_n_1k_.html"]
    end
  end
  describe "model_filename" do
    it "should sanitize filenames" do
      @nav.model_filename(" N&1k;;").should == "output/models/_n_1k_.html"
    end
  end
  describe "make_filename" do
    it "should sanitize filenames" do
      @nav.make_filename(" N&1k;;").should == "output/makes/_n_1k_.html"
    end
  end
end