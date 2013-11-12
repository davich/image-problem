require 'spec_helper'

describe Generator do
  it "should raise exception if input file is invalid" do
    filename = File.join(File.dirname(__FILE__), "..", "input_data", "test1.xml")
    lambda {
      @generator = Generator.new(filename, "unknown_folder3029423")
    }.should raise_exception
  end
  it "should raise exception if output folder doesn't exist" do
    filename = File.join(File.dirname(__FILE__), "..", "input_data", "unknown_file32948.xml")
    lambda {
      @generator = Generator.new(filename, "output")
    }.should raise_exception
  end

  describe "generate" do
    before do
      filename = File.join(File.dirname(__FILE__), "..", "input_data/test1.xml")
      @generator = Generator.new(filename, "output")
    end
    it "should create Make html" do
      @generator.should_receive(:write_file) # model file
      @generator.should_receive(:write_file).once do |filename, html|
        filename.should == File.join("output", "makes", "nikon_corporation.html")
        html.should include "<title>Camera Make: NIKON CORPORATION</title>"
        html.should include "<h1>Camera Make: NIKON CORPORATION</h1>"
        html.should include "<a href=\"../index.html\">Index</a>"
        html.should include "<a href=\"../models/nikon_d80.html\">NIKON D80</a>"
        html.should include "<img src=\"http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg\" alt=\"162042.jpg\" />"
      end
      @generator.should_receive(:write_file) # index file
      @html = @generator.generate
    end
    it "should create Model html" do
      @generator.should_receive(:write_file).once do |filename, html|
        filename.should == File.join("output", "models", "nikon_d80.html")
        html.should include "<title>Camera Model: NIKON D80</title>"
        html.should include "<h1>Camera Model: NIKON D80</h1>"
        html.should include "<a href=\"../index.html\">Index</a>"
        html.should include "<a href=\"../makes/nikon_corporation.html\">NIKON CORPORATION</a>"
        html.should include "<img src=\"http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg\" alt=\"162042.jpg\" />"
      end
      @generator.should_receive(:write_file).twice # make and index files
      @html = @generator.generate
    end
    it "should create Index html" do
      @generator.should_receive(:write_file).twice # make and model files

      @generator.should_receive(:write_file).once do |filename, html|
        filename.should == File.join("output", "index.html")
        html.should include "<title>Index</title>"
        html.should include "<h1>Index</h1>"
        html.should include "<a href=\"makes/nikon_corporation.html\">NIKON CORPORATION</a>"
        html.should include "<img src=\"http://ih1.redbubble.net/work.31820.1.flat,135x135,075,f.jpg\" alt=\"162042.jpg\" />"
      end
      @html = @generator.generate
    end
  end

end