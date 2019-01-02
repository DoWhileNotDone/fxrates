class ExchangeRateController < ApplicationController

 include ExchangeRate
 include FeedFactory

=begin
Retrieve the two selected rates from the data-store for the supplied date
@param Date (Date) e.g. {2018-12-31}
@param FromCCY (string) e.g. 'EUR' - the rate the user wished to convert from
@param TOCCY (string) e.g. 'USD' - the rate the user wished to convert to
@return Rate (float) or nil if not found
=end
 def showrate
   @rate = at(params[:date], params[:fromccy], params[:toccy])
 end

=begin
Fetch Data from the external feed, and persist to the currency table, using the requested feed type
@param Source (String) e.g. 'ECB' The vendor name for grouping the feeds 
@param Type (string) e.g. 'daily' - The specific feed type from the vendor
@return Void
=end
 def fromsource
   feed = FeedFactory.getFeedBySourceType(params[:source], params[:type])
   unless feed.nil?
      feed.fetch
   end
 end
end
