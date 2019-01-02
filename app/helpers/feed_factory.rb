require 'rexml/document'
require 'net/http'

module FeedFactory

    module FeedFetcherTypes
      TYPE_HTTP = 'HTTP';
    end

    module FeedParserTypes
      TYPE_ECB = 'ECB';
    end

=begin
Fetch the data from the URI
@param  string uri The data source
@return [data]     The data retrieved
=end
    class HTTPFeedFetcher
      public
      def fetch(uri)
          #FIXME: Handle unavailable data source
          Net::HTTP.get(URI(uri))
      end
    end

=begin
Parse the supplied data into array values that can be consumed
by the database for a new currency record
@param  xml A SimpleXMLElement containing the data elements
@return Yields an array of the results

FIXME 
 * Was hoping to use Yield here...
 * Not sure if this needs to be enumerable either at class or method level
 
A lot of this code was cribbed from
https://github.com/fixerAPI/fixer/tree/master/gem

=end
    class ECBFeedParser
      def parse (xml)
        document = REXML::Document.new(xml)

        REXML::XPath.each(document, '/gesmes:Envelope/Cube/Cube[@time]') do |day|
          date = Date.parse(day.attribute('time').value)
          #Include a Base EUR reference for each date
          #TODO: Set the EUR in a constant
          currency = Currency.find_by(iso_code: 'EUR', date: date)
          if(currency.nil?)
            currency = Currency.new
            currency.iso_code = 'EUR'
            currency.date = date
            currency.rate = Float(1)
            currency.save
          end

          REXML::XPath.each(day, './Cube') do |currency_data|
            iso_code = currency_data.attribute('currency').value
            currency = Currency.find_by(iso_code: iso_code, date: date)
            if(currency.nil?)
              currency = Currency.new
              currency.iso_code = iso_code
              currency.date = date
              currency.rate = Float(currency_data.attribute('rate').value)
              currency.save
            end
          end
        end
      end
    end

    class Feed

      def initialize(
          uri,
          fetcher,
          parser
      )
            @uri = uri
            @fetcher = fetcher
            @parser = parser
      end

      def fetch
        data = @fetcher.fetch(@uri)
        @parser.parse(data)
      end
    end

=begin
Get the Feed Record to populate the feed handler
@param Source (String) e.g. 'ECB' The vendor name for grouping the feeds 
@param Type (string) e.g. 'daily' - The specific feed type from the vendor
@return Void
=end
    def self.getFeedBySourceType(source, type)

      feedtype = FeedType.find_by(source: source, feed_type: type)

      if feedtype.nil?
          #logger.warn "No feed type found for '#{source}', '#{type}'"
          return nil
      end

      #If the database table is not configured correctly, that will throw an exception
      return Feed.new(
          feedtype.uri,
          getFeedFetcher(feedtype.fetcher_type),
          getFeedParser(feedtype.parser_type)
      )

    end

    def self.getFeedFetcher(type)
      case type
      when FeedFetcherTypes::TYPE_HTTP
          feedfetcher = HTTPFeedFetcher.new()
        else
          #@logger.warn "No feed fetcher found for requested type: '#{type}''"
          #TODO Throw Exception
          feedfetcher = nil
      end
      return feedfetcher
    end


    def self.getFeedParser(type)
      case type
        when FeedParserTypes::TYPE_ECB
          feedparser = ECBFeedParser.new()
        else
          #@logger.warn "No feed parser found for requested type: '#{type}''"
          #TODO Throw Exception
          feedparser = nil
      end
      return feedparser
    end

end
