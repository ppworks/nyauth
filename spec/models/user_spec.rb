require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }
  it { expect(user).to be_persisted }
  it_behaves_like 'Nyauth::Authenticatable', User
  it_behaves_like 'Nyauth::Confirmable', User
  it_behaves_like 'Nyauth::NewPasswordAvility', User
end
