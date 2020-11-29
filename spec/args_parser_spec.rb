require 'args_parser'

describe ArgsParser do
  it 'identifies target format and file names with format at the beginning' do
    given_arguments = ['--format', 'json', 'journals.csv', 'articles.csv', 'authors.csv']

    expect(ArgsParser.parse(given_arguments)).to eq({ format: 'json', files: ['journals.csv', 'articles.csv', 'authors.csv']})
  end

  it 'identifies target format and file names with format at the end' do
    given_arguments = ['journals.csv', 'articles.csv', 'authors.csv', '--format', 'json']

    expect(ArgsParser.parse(given_arguments)).to eq({ format: 'json', files: ['journals.csv', 'articles.csv', 'authors.csv']})
  end
end
