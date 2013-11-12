class Nav
  def self.index_nav(makes)
    nav(makes, "makes")
  end
  def self.makes_nav(models)
    [["Index", "../index.html"]] + nav(models, "../models")
  end
  def self.models_nav(make)
    [ ["Index", "../index.html"],
       [make, "../makes/#{sanitize_filename(make)}.html"] ]
  end
  def self.model_filename(model)
    "output/models/#{sanitize_filename(model)}.html"
  end
  def self.make_filename(make)
    "output/makes/#{sanitize_filename(make)}.html"
  end
  def self.index_filename
    "output/index.html"
  end
private
  def self.sanitize_filename(name)
    name.gsub(/^.*(\\|\/)/, '').gsub(/[^0-9A-Za-z.\-]/, '_').downcase
  end
  def self.nav(names, path)
    urls = names.collect {|model| "#{path}/#{sanitize_filename(model)}.html" }
    names.zip(urls)
  end
end