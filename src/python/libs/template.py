from jinja2 import Environment, FileSystemLoader

class Template:
  def __init__(self, template_file = '', data = ''):
    self.template_file = template_file
    self.data = data

  def render(self):
    jinja2_environment = Environment(loader=FileSystemLoader('src/python/template'))
    template = jinja2_environment.get_template(self.template_file)
    return template.render(data=self.data)

  def write(self,output_file):
    template_string = self.render()
    with open(output_file, "w") as file_handler:
      file_handler.write(template_string)
