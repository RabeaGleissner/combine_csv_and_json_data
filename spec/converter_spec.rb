require 'converter'

describe Converter do
  let(:converter) {Converter.new}
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
      journal: 'Rodriguez-Grant',
      author: 'Brendon Balistreri Sr., Ahmad Pouros MD',
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

  it 'converts input to json format' do
    expected_json_output = "[{\"doi\":\"10.1234/altmetric989\",\"title\":\"Fantastic Concrete Computer\",\"author\":\"Mr. Declan Wilderman\",\"journal\":\"Sanford, Hansen and Bednar\",\"issn\":\"7125-4516\"}]"
    expect(converter.to_json([combined_data[0]])).to eq(expected_json_output)
  end

  it 'converts input to csv format' do
    expected_csv_output = [
      ['DOI', 'Article title', 'Author name', 'Journal title', 'Journal ISSN'],
      ['10.1234/altmetric989', 'Fantastic Concrete Computer', 'Mr. Declan Wilderman','Sanford, Hansen and Bednar', '7125-4516'],
      ['10.1234/altmetric99', 'Intelligent Rubber Shirt', 'Brendon Balistreri Sr., Ahmad Pouros MD', 'Rodriguez-Grant', '9024-1117'],
      ['10.1234/altmetric990', 'Sleek Rubber Computer', 'Ahmad Pouros MD', 'Braun and Sons', '5747-4525'],
    ]
    expect(CSV.parse(converter.to_csv(combined_data))).to eq(expected_csv_output)
  end
end
