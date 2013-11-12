require_relative './work.rb'
require_relative './nav.rb'
require 'erb'

class Generator
  def initialize(input_filename, output_path)
    validate_params(input_filename, output_path)
    @input_filename = input_filename
    @nav = Nav.new(output_path)
  end

  def generate
    works = Work.from_xml(@input_filename)
    makes = works.group_by(&:make)
    makes.each do |make, works_for_make|
      process_make(make, works_for_make)
    end

    create_index_file(makes.keys, works)
  end

private
  def create_index_file(makes, works)
    content = html("Index", @nav.index_links(makes), works)
    write_file(@nav.index_filename, content)
  end

  def process_make(make, works) 
    models = works.group_by(&:model)
    models.each do |model, works_for_model|
      create_file_for_model(make, model, works_for_model)
    end
    create_file_for_make(make, models.keys, works)
  end

  def create_file_for_make(make, models, works)
    title = "Camera Make: #{make}"
    content = html(title, @nav.make_links(models), works)
    write_file(@nav.make_filename(make), content)
  end

  def create_file_for_model(make, model, works)
    title = "Camera Model: #{model}"
    content = html(title, @nav.model_links(make), works)
    write_file(@nav.model_filename(model), content)
  end

  def html(title, nav_links, works)
    works = works.first(10)
    ERB.new(File.read(File.join("templates", "output.html.erb"))).result(binding)
  end

  def write_file(filename, content)
    File.open(filename, 'w') { |file| file.write(content) }
  end

  def validate_params(input_filename, output_path)
    unless input_filename && File.exist?(input_filename)
      raise "Input file does not exist: #{input_filename}"
    end
    unless output_path && File.directory?(output_path)
      raise "Output directory does not exist: #{output_path}"
    end
  end
end