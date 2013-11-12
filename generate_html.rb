require './lib/work.rb'
require './lib/nav.rb'
require 'erb'

class GenerateHtml
  def generate(filename)
    works = Work.from_xml(filename)
    makes = works.group_by(&:make)
    makes.each do |make, works_for_make|
      handle_make(make, works_for_make)
    end
    write_file(Nav.index_filename, html("Index", Nav.index_nav(makes.keys), works))
  end

  def handle_make(make, works) 
    models = works.group_by(&:model)
    models.each do |model, works_for_model|
      handle_model(make, model, works_for_model)
    end
    title = "Camera Make: #{make}"
    content = html(title, Nav.makes_nav(models.keys), works)
    write_file(Nav.make_filename(make), content)
  end

  def handle_model(make, model, works)
    title = "Camera Model: #{model}"
    content = html(title, Nav.models_nav(make), works)
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