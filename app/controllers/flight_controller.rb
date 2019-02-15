class FlightController
  def fetch_flight
    customer_type = params[customer_type]
    departing_date = params[departing_date]
    returning_date = params[returning_date]
    from = params[from] || 'Xi‘an'
    to = params[to] || 'Chengdu'

    fromFlightIds = Flight.where(from: from).pluck(:id)
    toFlightIds = Flight.where(from: to).pluck(:id)
    departing = is_weekday(departing_date)
    returning = is_weekday(departing_date)
    fromFlightPrice = FlightPrice.where(:flight_type => customer_type, is_weekday: departing, :flight_id.in => fromFlightIds)
                                 .order_by(price: :desc)

    toFlightsPrice = FlightsPrice.where(:flight_type => customer_type, is_weekday: returning, :flight_id.in => toFlightIds)
                                 .order_by(price: :desc)

    fromFlight = fromFlightPrice.includes(:flight)
    toFlight = toFlightPrice.includes(:flight)

    fromPrice = fromFlightPrice.pluck(:price)
    toPrice = toFlightsPrice.pluck(:price)

    priceIndex = []
    fromPrice.each_with_index do |value, index|
      currentPrice = toPrice[index] + value
      if index === 0
        LowPrice = currentPrice
        priceIndex.push index
      elsif LowPrice === currentPrice
        priceIndex.push index
      end
    end

    if priceIndex.count === 1 
      currentIndex = priceIndex[0]
      {
        departingFlight = fromFlight[currentIndex].name
        returningFlight = toFlight[currentIndex].name
      }
      return json: {
        departingFlight = fromFlight[currentIndex].name
        returningFlight = toFlight[currentIndex].name
      }, status: 200
    end

    preferred_time = 12:00
    currentIndex = 0
    priceIndex.each_with_index do |value, index|
      #和12:00做比较，取最小值的index
      
    end
    return json: {
        departingFlight = fromFlight[currentIndex].name
        returningFlight = toFlight[currentIndex].name
      }, status: 200
  end

  private

  def is_weekday

  end
end