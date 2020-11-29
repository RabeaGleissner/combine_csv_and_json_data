require 'csv'
require 'json'

CSV_HEADER = ['DOI', 'Article title', 'Author name', 'Journal title', 'Journal ISSN']

class Converter
  def to_json(data)
    JSON.generate(data)
  end

  def to_csv(data)
    CSV.generate do |csv|
      csv <<  CSV_HEADER
      data.each do |row|
        ordered_columns = []
        ordered_columns << row[:doi]
        ordered_columns << row[:title]
        ordered_columns << row[:author]
        ordered_columns << row[:journal]
        ordered_columns << row[:issn]
        csv << ordered_columns
      end
    end
  end
end
