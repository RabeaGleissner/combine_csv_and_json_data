require 'csv'
require 'json'

KEYS_WITH_HEADERS = {
  doi: 'DOI',
  title: 'Article title',
  author: 'Author name',
  journal: 'Journal title',
  issn: 'Journal ISSN',
}

class Converter
  def to_json(data)
    JSON.generate(data)
  end

  def to_csv(data)
    CSV.generate do |csv|
      csv <<  KEYS_WITH_HEADERS.values
      data.each do |row|
        csv << KEYS_WITH_HEADERS.keys.map {|key| row[key]}
      end
    end
  end
end
