require "rails_helper"

RSpec.describe Nyauth::RequestMailer do
  describe '#request_confirmation' do
    let(:user) { create(:user, :requested_confirmation) }
    subject(:mail) { Nyauth::RequestMailer.request_confirmation(user) }
    it { expect(mail).to have_body_text 'Plese confirm your email' }
  end

  describe '#request_reset_password' do
    let(:user) { create(:user, :requested_reset_password) }
    subject(:mail) { Nyauth::RequestMailer.request_reset_password(user) }
    it { expect(mail).to have_body_text 'Plese set your new password' }
  end
end
