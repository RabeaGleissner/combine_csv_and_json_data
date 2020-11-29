require 'csv'
require 'json'
require_relative 'lib/args_parser.rb'
require_relative 'lib/combiner.rb'


options = ArgsParser.parse(ARGV)
puts options

articles = CSV.open('resources/articles.csv', headers: true).map(&:to_h)
journals = CSV.open('resources/journals.csv', headers: true).map(&:to_h)
authors_json = File.read('resources/authors.json', headers: true)
authors = JSON.parse(authors_json)
puts authors
combiner = Combiner.new
output = combiner.combine(articles, journals, authors)
puts output

