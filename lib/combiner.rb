class Combiner
  def combine(articles_data, journals_data, authors_data)
    articles = articles_data.map do |row|
      formatted_row = format_keys(row)
      formatted_row[:issn] = fix_issn(formatted_row[:issn])
      formatted_row
    end

    journals = journals_data.map do |row|
      formatted_row = format_keys(row)
      formatted_row[:issn] = fix_issn(formatted_row[:issn])
      formatted_row
    end

    authors = authors_data.map do |row|
      formatted_row = format_keys(row)
      formatted_row
    end

    output = articles.map do |article|
      article[:journal] = journals.find{|journal| journal[:issn] == article[:issn]}[:title]
      article[:author] = authors.reduce('') do |memo, author|
        found_doi = author[:articles].find{ |author_article| author_article == article[:doi]}
        if found_doi
          memo += (memo.empty? ? "#{author[:name]}" : ", #{author[:name]}")
        end
        memo
      end
      article
    end
    output
  end

  def format_keys(row)
    row.to_h.transform_keys{|key| key.downcase.to_sym}
  end

  def fix_issn(issn)
    "#{issn.split(//).first(4).join}-#{issn.split(//).last(4).join}"
  end
end
