require "rails_helper"

RSpec.describe Nyauth::RequestMailer do
  describe '#request_confirmation' do
    let(:user) { create(:user, :requested_confirmation) }
    subject(:mail) { Nyauth::RequestMailer.request_confirmation(user) }
    it { expect(mail).to have_body_text 'Plese confirm your email' }
  end

  describe '#request_new_password' do
    let(:user) { create(:user, :requested_new_password) }
    subject(:mail) { Nyauth::RequestMailer.request_new_password(user) }
    it { expect(mail).to have_body_text 'Plese set your new password' }
  end
end
