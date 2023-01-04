RSpec.describe Order do
  # using Success/Failure in spec require Dry::Monads[:result] to be included
  include Dry::Monads[:result]

  describe '#deliver' do
    subject(:deliver) { described_class.new(dealer).deliver(2020, 'focus', 'london') }

    context 'when dealer is not able to deliver a car' do
      let(:dealer) { instance_double(Dealer, deliver: Failure('not able to deliver a car')) }

      it { is_expected.to eql Failure('not able to deliver a car') }
    end

    context 'when dealer has a car' do
      let(:car) { Car.new(2020, 'focus') }
      let(:dealer) { instance_double(Dealer, deliver: Success(car)) }

      it { is_expected.to eql Success(car) }
    end
  end
end
