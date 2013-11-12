require 'spec_helper'

describe GenerateHtml do
  describe "generate" do
    before do
      @generate_html = GenerateHtml.new
      @filename = "#{File.dirname(__FILE__)}/../input_data/test1.xml"
    end
    it "should create Make html" do
      @generate_html.should_receive(:write_file) # model file
      @generate_html.should_receive(:write_file).once do |filename, html|
        filename.should == "output/makes/nikon_corporation.html"
        html.should include "<title>Camera Make: NIKON CORPORATION</title>"
      end
      @generate_html.should_receive(:write_file) # index file
      @html = @generate_html.generate(@filename)
    end
    it "should create Model html" do
      @generate_html.should_receive(:write_file).once do |filename, html|
        filename.should == "output/models/nikon_d80.html"
        html.should include "<title>Camera Model: NIKON D80</title>"
      end
      @generate_html.should_receive(:write_file).twice # make and index file
      @html = @generate_html.generate(@filename)
    end
    it "should handle work without a make"
    it "should handle work without a model"
  end
end