require 'spec_helper'

describe GenerateHtml do
  describe "generate" do
    before do
      @generate_html = GenerateHtml.new
      @filename = "#{File.dirname(__FILE__)}/../input_data/test1.xml"
    end
    it "should create Make html" do
      @generate_html.should_receive(:write_file).once do |filename, html|
        filename.should == "output/make_NIKON_CORPORATION.html"
        html.should include "<title>NIKON CORPORATION</title>"
      end
      @generate_html.should_receive(:write_file).twice # model and index file
      @html = @generate_html.generate(@filename)
    end
    it "should create Model html" do
      @generate_html.should_receive(:write_file) # make file
      @generate_html.should_receive(:write_file).once do |filename, html|
        filename.should == "output/model_NIKON_D80.html"
        html.should include "<title>NIKON D80</title>"
      end
      @generate_html.should_receive(:write_file) # index file
      @html = @generate_html.generate(@filename)
    end
  end
end