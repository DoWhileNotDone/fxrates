# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
FeedType.create(source: 'ECB', feed_type: 'daily', uri: 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml', fetcher_type: 'HTTP', parser_type: 'ECB')
FeedType.create(source: 'ECB', feed_type: 'ninety_days', uri: 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml', fetcher_type: 'HTTP', parser_type: 'ECB')
FeedType.create(source: 'ECB', feed_type: 'historical', uri: 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist.xml', fetcher_type: 'HTTP', parser_type: 'ECB')
