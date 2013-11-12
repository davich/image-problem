require './lib/work.rb'
require './lib/nav.rb'
require 'erb'

class GenerateHtml
  def generate(filename)
    works = Work.from_xml(filename)
    makes = works.group_by(&:make)
    makes.each do |make, works_for_make|
      process_make(make, works_for_make)
    end

    create_index_file(makes.keys, works)
  end
  
private
  def create_index_file(makes, works)
    content = html("Index", Nav.index_links(makes), works)
    write_file(Nav.index_filename, content)
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
    content = html(title, Nav.make_links(models), works)
    write_file(Nav.make_filename(make), content)
  end

  def create_file_for_model(make, model, works)
    title = "Camera Model: #{model}"
    content = html(title, Nav.model_links(make), works)
    write_file(Nav.model_filename(model), content)
  end

  def html(title, nav, works)
    ERB.new(File.read("templates/output.html.erb")).result(binding)
  end

  def write_file(filename, content)
    File.open(filename, 'w') { |file| file.write(content) }
  end
end

GenerateHtml.new.generate ARGV[0] if ARGV[0]