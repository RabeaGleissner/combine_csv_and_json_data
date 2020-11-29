require 'csv'
require 'json'
require_relative 'lib/args_parser.rb'
require_relative 'lib/combiner.rb'
require_relative 'lib/converter.rb'

combiner = Combiner.new
converter = Converter.new
options = ArgsParser.parse(ARGV)

articles = CSV.open('resources/articles.csv', headers: true).map(&:to_h)
journals = CSV.open('resources/journals.csv', headers: true).map(&:to_h)
authors = JSON.parse(File.read('resources/authors.json', headers: true))

output = combiner.combine(articles, journals, authors)

if (options[:format] == 'json')
  puts converter.to_json(output)
end

if (options[:format] === 'csv')
  puts converter.to_csv(output)
end
