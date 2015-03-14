RSpec.shared_examples 'Nyauth::Authenticatable' do |klass|
  it_behaves_like 'Nyauth::PasswordDigestAbility', klass
  let!(:instance) { create(klass.name.downcase.to_sym, email: email, password: password) }

  describe '.authenticate' do
    let(:email) { 'correct@example.com' }
    let(:password) { 'password' }
    subject { klass.authenticate(given_email, given_password) }

    context 'when correct email' do
      let(:given_email) { email }
      context 'and correct password' do
        let(:given_password) { password }
        it { is_expected.to eq instance }
      end

      context 'and wrong password' do
        let(:given_password) { 'invalid' }
        it { is_expected.to be_nil }
      end
    end

    context 'when wrong email' do
      let(:given_email) { 'wrong@example.com' }
      context 'and correct password' do
        let(:given_password) { password }
        it { is_expected.to be_nil }
      end

      context 'and wrong password' do
        let(:given_password) { 'invalid' }
        it { is_expected.to be_nil }
      end
    end
  end
end
