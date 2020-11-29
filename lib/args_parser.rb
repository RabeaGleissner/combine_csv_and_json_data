class ArgsParser
  def self.parse(arguments)
    format_flag_index = arguments.find_index('--format')
    format = arguments[format_flag_index + 1]
    files = arguments.reject.with_index{|x, i| (i == format_flag_index || i == format_flag_index + 1 )}
    {format: format, files: files}
  end
end
