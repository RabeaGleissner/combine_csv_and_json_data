require 'combiner'

articles_data = [
  {'DOI'=>'10.1234/altmetric989', 'Title'=>'Fantastic Concrete Computer', 'ISSN'=>'71254516'},
  {'DOI'=>'10.1234/altmetric99', 'Title'=>'Intelligent Rubber Shirt', 'ISSN'=>'9024-1117'},
  {'DOI'=>'10.1234/altmetric990', 'Title'=>'Sleek Rubber Computer', 'ISSN'=>'5747-4525'},
]
journals_data = [
  {'Title'=>'Sanford, Hansen and Bednar', 'ISSN'=>'7125-4516'},
  {'Title'=>'Rodriguez-Grant', 'ISSN'=>'9024-1117'},
  {'Title'=>'Braun and Sons', 'ISSN'=>'57474525'},
]
authors_data = [
  {
    'name'=>'Mr. Declan Wilderman',
    'articles'=>['10.1234/altmetric807', '10.1234/altmetric989'],
  },
  {
    'name'=>'Brendon Balistreri Sr.',
    'articles'=>['10.1234/altmetric99', '10.1234/altmetric877', '10.1234/altmetric844', '10.1234/altmetric315'],
  },
  {
    'name'=>'Ahmad Pouros MD',
    'articles'=>['10.1234/altmetric990', '10.1234/altmetric99', '10.1234/altmetric806'],
  },
]

describe Combiner do
  let(:combiner) {Combiner.new}

  it 'converts all keys to downcase symbols' do
    unformatted_key_hash = {
      'First' => '1',
      'secOnd' => '2',
      'THIRD' => '3',
    }
    expect(combiner.format_keys(unformatted_key_hash)).to eq({ first: '1', second: '2', third: '3'})
  end

  it 'adds hyphen to issn if there is none' do
    expect(combiner.fix_issn('12345678')).to eq('1234-5678')
  end

  it 'does not add hyphen to issn if there is one already' do
    expect(combiner.fix_issn('1234-5678')).to eq('1234-5678')
  end

  it 'combines author, journals and articles data' do
    combined_data = [
      {
        doi: '10.1234/altmetric989',
        title: 'Fantastic Concrete Computer',
        author: 'Mr. Declan Wilderman',
        journal: 'Sanford, Hansen and Bednar',
        issn: '7125-4516',
      },
      {
        doi: '10.1234/altmetric99',
        title: 'Intelligent Rubber Shirt',
        author: 'Brendon Balistreri Sr., Ahmad Pouros MD',
        journal: 'Rodriguez-Grant',
        issn: '9024-1117',
      },
      {
        doi: '10.1234/altmetric990',
        title: 'Sleek Rubber Computer',
        author: 'Ahmad Pouros MD',
        journal: 'Braun and Sons',
        issn: '5747-4525',
      },
    ]

    output = combiner.combine(articles_data, journals_data, authors_data)
    expect(output).to eq(combined_data)
  end
end
