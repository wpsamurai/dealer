class NewDealer
  AVAILABLE_MODELS = %w[corolla focus mondeo]
  AVAILABLE_CITIES = %w[paris london warsaw]

  include Dry::Monads[:result, :do]

  def delivery(year, model, city)
    yield check_year(year)
    yield check_model(model)
    yield check_city(city)

    Success(Car.new(year, model))
  end

  private

  def check_year(year)
    year < 2000 ? Failure("We have no cars manufactured in year #{year}") : Success('Cars of this year are available')
  end

  def check_city(city)
    AVAILABLE_CITIES.include?(city) ? Success("Car deliverable to #{city}") : Failure('Apologies, we cannot deliver to this city')
  end

  def check_model(model)
    AVAILABLE_MODELS.include?(model) ? Success('Model available') : Failure('The model requested is unavailable')
  end
end
