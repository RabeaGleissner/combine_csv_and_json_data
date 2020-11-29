require 'args_parser'

describe ArgsParser do
  it 'identifies target format and file names with format at the beginning' do
    given_arguments = ['--format', 'json', 'journals.csv', 'articles.csv', 'authors.json']
    args_parser = ArgsParser.new(given_arguments)

    expect(args_parser.output_format).to eq('json')
  end

  it 'identifies target format and file names with format at the end' do
    given_arguments = ['journals.csv', 'articles.csv', 'authors.json', '--format', 'json']
    args_parser = ArgsParser.new(given_arguments)

    expect(args_parser.output_format).to eq('json')
  end

  it 'errors if number of files is not 3' do
    given_arguments = ['journals.csv', 'articles.csv', '--format', 'json']
    args_parser = ArgsParser.new(given_arguments)

    expect {args_parser.validate_requested_files}.to raise_exception('Invalid file options given')
  end

  it 'errors if files are different from expected' do
    given_arguments = ['papers.csv', 'words.csv', 'writers.csv', '--format', 'json']

    args_parser = ArgsParser.new(given_arguments)
    expect {args_parser.validate_requested_files}.to raise_exception('Invalid file options given')
  end

  it 'errors if unexpected format is requested' do
    given_arguments = ['--format', 'html', 'journals.csv', 'articles.csv', 'authors.json']

    expect {ArgsParser.new(given_arguments)}.to raise_exception('Invalid output format given')
  end
end
