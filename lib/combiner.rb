class Combiner
  def format_rows(rows)
    rows.map do |row|
      formatted_row = format_keys(row)
      if formatted_row.key?(:issn)
        formatted_row[:issn] = fix_issn(formatted_row[:issn])
      end
      formatted_row
    end
  end

  def combine(articles_data, journals_data, authors_data)
    articles = format_rows(articles_data)
    journals = format_rows(journals_data)
    authors = format_rows(authors_data)

    articles.map do |article|
      article[:journal] = journals.find{|journal| journal[:issn] == article[:issn]}[:title]
      article[:author] = authors.reduce('') do |memo, author|
        matching_doi = author[:articles].find{|author_article| author_article == article[:doi]}
        if matching_doi
          memo += (memo.empty? ? "#{author[:name]}" : ", #{author[:name]}")
        end
        memo
      end
      article
    end
  end

  def format_keys(row)
    row.to_h.transform_keys{|key| key.downcase.to_sym}
  end

  def fix_issn(issn)
    issn_array = issn.split(//)
    "#{issn_array.first(4).join}-#{issn_array.last(4).join}"
  end
end
