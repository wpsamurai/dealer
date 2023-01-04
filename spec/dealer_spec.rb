RSpec.describe Dealer do
  describe '#deliver' do
    context 'when car is too old' do
      subject(:delivery) { described_class.new.deliver(1900, 'focus', 'london') }

      it 'fails' do
        expect(delivery).not_to be_success
        expect { delivery.value! }.to raise_error Dry::Monads::UnwrapError
        expect(delivery.value_or('default value')).to eq 'default value'
        expect(delivery.success?).to eq false
        expect(delivery.failure?).to eq true
        expect(delivery.failure).to eq 'We have no cars manufactured in year 1900'
      end

      # using Success/Failure in spec require Dry::Monads[:result] to be included
      include Dry::Monads[:result]
      it { is_expected.to eql Failure('We have no cars manufactured in year 1900') }
    end

    context 'when car is available' do
      subject(:delivery) { described_class.new.deliver(2020, 'focus', 'london') }

      it 'returns a car' do
        expect(delivery).to be_success
        expect(delivery.success?).to eq true
        expect(delivery.value!).to be_kind_of Car
        expect(delivery.value_or).to be_kind_of Car
        expect(delivery.value_or('default value')).to be_kind_of Car
        expect(delivery.failure?).to eq false
      end
    end
  end
end
