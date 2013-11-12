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
        html.should include "<h1>Camera Make: NIKON CORPORATION</h1>"
        html.should include "<a href=\"../index.html\">Index</a>"
        html.should include "<a href=\"../models/nikon_d80.html\">NIKON D80</a>"
        html.should include "<img src=\"http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg\" alt=\"162042.jpg\" />"
      end
      @generate_html.should_receive(:write_file) # index file
      @html = @generate_html.generate(@filename)
    end
    it "should create Model html" do
      @generate_html.should_receive(:write_file).once do |filename, html|
        filename.should == "output/models/nikon_d80.html"
        html.should include "<title>Camera Model: NIKON D80</title>"
        html.should include "<h1>Camera Model: NIKON D80</h1>"
        html.should include "<a href=\"../index.html\">Index</a>"
        html.should include "<a href=\"../makes/nikon_corporation.html\">NIKON CORPORATION</a>"
        html.should include "<img src=\"http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg\" alt=\"162042.jpg\" />"
      end
      @generate_html.should_receive(:write_file).twice # make and index files
      @html = @generate_html.generate(@filename)
    end
    it "should create Index html" do
      @generate_html.should_receive(:write_file).twice # make and model files

      @generate_html.should_receive(:write_file).once do |filename, html|
        filename.should == "output/index.html"
        html.should include "<title>Index</title>"
        html.should include "<h1>Index</h1>"
        html.should include "<a href=\"makes/nikon_corporation.html\">NIKON CORPORATION</a>"
        html.should include "<img src=\"http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg\" alt=\"162042.jpg\" />"
      end
      @html = @generate_html.generate(@filename)
    end
  end
end