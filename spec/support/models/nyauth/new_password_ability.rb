RSpec.shared_examples 'Nyauth::NewPasswordAvility' do |klass|
  let!(:instance) { create(klass.name.downcase.to_sym) }

  describe '#request_new_password' do
    subject { instance.request_new_password }

    it do
      expect {
        subject
      }.to change(instance, :new_password_key).from(nil)
    end
  end
end
