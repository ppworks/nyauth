RSpec.shared_examples 'Nyauth::Confirmable' do |klass|
  let!(:instance) { create(klass.name.downcase.to_sym, :requested_confirmation) }

  describe '#confirm' do
    subject { instance.confirm }
    before { Timecop.freeze }
    after { Timecop.return }

    it do
      expect {
        subject
      }.to change(instance, :confirmed?).from(false).to(true)
    end

    it do
      expect {
        subject
      }.to change(instance, :confirmed_at).from(nil).to(Time.current)
    end

    it do
      expect {
        subject
      }.to change(instance, :confirmation_key).to(nil)
    end
  end
end
