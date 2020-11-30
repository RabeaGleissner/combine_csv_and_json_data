# Combining data from CSV and JSON files

Task: combine the data in the three files in the `resources` directory.

Expected output formats:

* CSV with columns of DOI, Article title, Author name, Journal title and
  Journal ISSN, e.g.

  10.1234/altmetric0,Small Wooden Chair,Amari Lubowitz,"Shanahan, Green and Ziemann",1337-8688

* JSON as an array of objects with fields for DOI, title, author, journal and
  ISSN, e.g.

    {
        "doi": "10.1234/altmetric0",
        "title": "Small Wooden Chair",
        "author": "Amari Lubowitz",
        "journal": "Shanahan, Green and Ziemann",
        "issn": "1337-8688"
    }


### Running instructions

`bundle install`

Generate a JSON file or CSV file like this:

`ruby combine.rb --format json journals.csv articles.csv authors.json > full_articles.json`

`ruby combine.rb --format csv journals.csv articles.csv authors.json > full_articles.csv`

Run tests with

`rspec`
