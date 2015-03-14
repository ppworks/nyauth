RSpec.shared_examples 'Nyauth::PasswordDigestAbility' do |klass|
  let(:instance) { create(klass.name.downcase.to_sym, password: password) }

  describe '#verify_password?' do
    let(:password) { 'password' }
    subject { instance.verify_password?(given_password) }

    context 'when correct password' do
      let(:given_password) { password }
      it { is_expected.to be true }
    end

    context 'when wrong password' do
      let(:given_password) { 'invalid' }
      it { is_expected.to be false }
    end
  end
end
