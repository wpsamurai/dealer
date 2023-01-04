class Order
  def initialize(dealer)
    @dealer = dealer
  end

  def deliver(year, model, city)
    dealer.deliver(year, model, city)
  end

  private

    attr_reader :dealer
end
