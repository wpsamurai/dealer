# An example class with "do" notation
# https://dry-rb.org/gems/dry-monads/1.3/do-notation/
class DoDealer
  AVAILABLE_MODELS = %w[corolla focus mondeo].freeze
  AVAILABLE_CITIES = %w[paris london warsaw].freeze

  include Dry::Monads[:result, :do]

  def deliver(year, model, city)
    yield check_year(year)
    yield check_model(model)
    yield check_city(city)

    Success(prepare_car(year, model))
  end

  private

    def prepare_car(year, model)
      Car.new(year, model)
    end

    def check_year(year)
      year < 2000 ? Failure("We have no cars manufactured in year #{year}") : Success('Cars of this year are available')
    end

    def check_city(city)
      return Success("Car deliverable to #{city}") if AVAILABLE_CITIES.include?(city)

      Failure('Apologies, we cannot deliver to this city')
    end

    def check_model(model)
      AVAILABLE_MODELS.include?(model) ? Success('Model available') : Failure('The model requested is unavailable')
    end
end
