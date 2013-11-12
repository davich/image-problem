require 'spec_helper'

describe Work do
  describe "from_xml" do
    context "complete test data" do
      before(:all) do
        @results = Work.from_xml("#{File.dirname(__FILE__)}/../input_data/test1.xml")
        @work = @results.first
      end
      it "should only find one result" do
        @results.size.should == 1
      end
      it "should load the make" do
        @work.make.should == "NIKON CORPORATION"
      end
      it "should load the model" do
        @work.model.should == "NIKON D80"
      end
      it "should load the id" do
        @work.id.should == "31820"
      end
      it "should load the url" do
        @work.url.should == "http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg"
      end
      it "should load the filename" do
        @work.filename.should == "162042.jpg"
      end
    end
    context "incomplete test data" do
      it "should reject work with no make" do
        results = Work.from_xml("#{File.dirname(__FILE__)}/../input_data/test2.xml")
        results.size.should == 0
      end
      it "should reject work with no model" do
        results = Work.from_xml("#{File.dirname(__FILE__)}/../input_data/test3.xml")
        results.size.should == 0
      end
    end
  end
end