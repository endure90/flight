class FlightPrice
  extend Enumerize

  FLIGHTTYPE = {
    regular: '正常',
    reward: '优惠'
  }.with_indifferent_access.freeze

  field :is_weekday, type: Boolean, default: false
  enumerize :flight_type, in: FLIGHTTYPE.keys.map(&:to_sym), default: :regular
  field :price, type: Float, default: 0.0

  belongs_to :flight

  index({ price: 1 })
end
