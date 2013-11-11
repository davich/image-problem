require 'nokogiri'

class Work
  def self.from_xml(filename)
    doc = Nokogiri::XML(File.open(filename))
    doc.search("works/work").collect do |node|
      Work.new(node)
    end
  end
  def initialize(node)
    @node = node
  end
  def make
    attr("exif/make")
  end
  def model
    attr("exif/model")
  end
  def id
    attr("id")
  end
  def url
    attr("urls/url[@type='small']")
  end
  def filename
    attr("filename")
  end
private
  def attr(xpath)
    node = @node.search(xpath).first
    node.nil? ? nil : node.content
  end
end