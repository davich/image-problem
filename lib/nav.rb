class Nav
  def self.index(makes)
    urls = makes.collect {|make| "makes/#{sanitize_filename(make)}.html" }
    Hash[makes.zip(urls)]
  end
  def self.makes(models)
    urls = models.collect {|model| "../models/#{sanitize_filename(model)}.html" }
    Hash[models.zip(urls)]
  end
  def self.models(make)
    { "Index" => "../index.html", make => "../makes/#{sanitize_filename(make)}.html" }
  end
  def self.sanitize_filename(name)
    name.gsub(/^.*(\\|\/)/, '').gsub(/[^0-9A-Za-z.\-]/, '_').downcase
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
end