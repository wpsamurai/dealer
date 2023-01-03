class Dealer
  AVAILABLE_MODELS = %w[corolla focus mondeo].freeze
  AVAILABLE_CITIES = %w[paris london warsaw].freeze

  include Dry::Monads[:result]

  def deliver(year, model, city)
    return Failure("We have no cars manufactured in year #{year}") if year < 2000
    return Failure('The model requested is unavailable') unless model_available?(model)
    return Failure('Apologies, we cannot deliver to this city') unless city_available?(city)

    Success(Car.new(year, model))
  end

  private

    def model_available?(model)
      AVAILABLE_MODELS.include?(model)
    end

    def city_available?(city)
      AVAILABLE_CITIES.include?(city)
    end
end
