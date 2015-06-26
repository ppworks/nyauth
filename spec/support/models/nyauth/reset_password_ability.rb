RSpec.shared_examples 'Nyauth::ResetPasswordAvility' do |klass|
  let!(:instance) { create(klass.name.downcase.to_sym) }

  describe '#request_reset_password' do
    subject { instance.request_reset_password }

    it do
      expect {
        subject
      }.to change(instance, :reset_password_key).from(nil)
    end
  end
end
