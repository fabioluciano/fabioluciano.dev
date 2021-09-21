import csv

class CSVWritter:
  def __init__(self, data):
    self.data = data

  def write(self, output_file = ''):
    file_handler = open(output_file, 'w')
    dict_writer = csv.DictWriter(file_handler, self.data[0].keys())
    dict_writer.writerows(self.data)
