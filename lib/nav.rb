class Nav
  def initialize(output_path)
    @output_path = output_path
    create_subdirectories
  end
  def index_links(makes)
    nav_links(makes, "makes")
  end
  def make_links(models)
    [["Index", File.join("..", "index.html")]] + nav_links(models, File.join("..", "models"))
  end
  def model_links(make)
    [
      ["Index", File.join("..", "index.html")],
      [make, File.join("..", "makes", "#{sanitize_filename(make)}.html")]
    ]
  end
  def make_filename(make)
    File.join(@output_path, "makes", "#{sanitize_filename(make)}.html")
  end
  def model_filename(model)
    File.join(@output_path, "models", "#{sanitize_filename(model)}.html")
  end
  def index_filename
    File.join(@output_path, "index.html")
  end
private
  def create_subdirectories
    ["makes", "models"].each do |name|
      dir = File.join(@output_path, name)
      Dir.mkdir(dir) unless File.directory?(dir)
    end
  end
  def sanitize_filename(name)
    name.downcase.gsub(/^.*(\\|\/)/, '').gsub(/[^\w\d.\-]+/, '_')
  end
  def nav_links(names, path)
    urls = names.collect {|model| File.join(path, "#{sanitize_filename(model)}.html") }
    names.zip(urls).sort
  end
end