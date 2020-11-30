require 'args_parser'

describe ArgsParser do
  it 'identifies target format' do
    arguments = ['--format', 'json', 'journals.csv', 'articles.csv', 'authors.json']
    args_parser = ArgsParser.new(arguments)

    expect(args_parser.output_format).to eq('json')
  end

  it 'identifies target format when format is given as last argument' do
    arguments = ['journals.csv', 'articles.csv', 'authors.json', '--format', 'json']
    args_parser = ArgsParser.new(arguments)

    expect(args_parser.output_format).to eq('json')
  end

  it 'errors if number of files is not 3' do
    arguments = ['journals.csv', 'articles.csv', '--format', 'json']
    args_parser = ArgsParser.new(arguments)

    expect {args_parser.validate_requested_files}.to raise_exception('Invalid file options given')
  end

  it 'errors if files are different from expected' do
    arguments = ['papers.csv', 'words.csv', 'writers.csv', '--format', 'json']
    args_parser = ArgsParser.new(arguments)

    expect {args_parser.validate_requested_files}.to raise_exception('Invalid file options given')
  end

  it 'errors if unexpected format is requested' do
    arguments = ['--format', 'html', 'journals.csv', 'articles.csv', 'authors.json']

    expect {ArgsParser.new(arguments)}.to raise_exception('Invalid output format given')
  end
end
