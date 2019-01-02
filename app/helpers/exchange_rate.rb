module ExchangeRate

=begin
Retrieve the two selected rates from the data-store for the supplied date
@param Date (Date) e.g. {2018-12-31}
@param FromCCY (string) e.g. 'EUR' - the rate the user wished to convert from
@param TOCCY (string) e.g. 'USD' - the rate the user wished to convert to
@return Rate (float) or nil if not found
=end
  def self.at(date, fromccy, toccy)

      @fromcurrency = Currency.find_by(iso_code: fromccy, date: date)

      if @fromcurrency.nil?
        #TODO: Add Logging
        return nil
      end

      #TODO: Format/Validate the supplied date
      @tocurrency = Currency.find_by(iso_code:  params[:toccy], date: params[:date])

      if @tocurrency.nil?
        #TODO: Add Logging
        return nil
      end

      fromrate = @fromcurrency.rate
      torate = @tocurrency.rate

      # Calculate Cross Rate between currencies
      # https://www.markettraders.com/blog/easily-calculate-cross-currency-rates/

      #TODO: Need to check if I can round down
      #TODO: Moved the formatting into the template, and let it decide how to display
      1/fromrate * torate

  end

end
