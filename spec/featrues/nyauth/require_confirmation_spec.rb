require 'rails_helper'

RSpec.describe 'Require confirmation' do
  feature 'visit page which requires confirmation' do
    background { sign_in user }

    context 'when confirmed user' do
      let(:user) { create(:user, :confirmed) }
      background { visit edit_notification_path }

      scenario 'can see page' do
        expect(page).to have_content('Notification Settings')
      end
    end

    context 'when not confirmed user' do
      let(:user) { create(:user) }
      background { visit edit_notification_path }

      scenario "can't see page" do
        expect(page).not_to have_content('Notification Settings')
        expect(current_path).to eq nyauth.new_confirmation_request_path
      end
    end
  end
end
