VALID_FILES = ['articles.csv', 'authors.json', 'journals.csv']

class ArgsParser
  attr_reader :output_format

  def initialize(arguments)
    @arguments = arguments
    @format_flag_index = arguments.find_index('--format')
    @output_format = find_format
    @files = find_files
  end

  def validate_requested_files
    unless @files.length == 3 && VALID_FILES.sort == @files.sort
      raise 'Invalid file options given'
    end
  end

  private

  def find_files
    @arguments.reject.with_index do |_, i|
      i == @format_flag_index || i == @format_flag_index + 1
    end
  end

  def find_format
    format = @arguments[@format_flag_index + 1]
    unless ['csv', 'json'].include?(format)
      raise 'Invalid output format given'
    end
    format
  end
end
