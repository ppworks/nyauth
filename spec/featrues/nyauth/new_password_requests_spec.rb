require 'rails_helper'

RSpec.describe 'Nyauth::NewPasswordRequests' do
  let!(:user) { create(:user) }

  feature 'confirmation' do
    let(:new_password) { 'cool_password' }
    background do
      visit nyauth.new_new_password_request_path
    end

    scenario 'request & set new password' do
      fill_in('user_email', with: user.email)
      click_button('request new password')

      open_email(user.email)
      current_email.click_link('set new password')

      fill_in('user_password', with: new_password)
      fill_in('user_password_confirmation', with: new_password)
      click_button('Update')

      expect(page).to have_content('updated')
      expect(current_path).to eq nyauth.new_session_path
    end

    scenario 'request expired' do
      fill_in('user_email', with: user.email)
      click_button('request new password')

      Timecop.freeze(Time.current + 3.hours) do
        open_email(user.email)
        current_email.click_link('set new password')

        fill_in('user_password', with: new_password)
        fill_in('user_password_confirmation', with: new_password)
        click_button('Update')

        expect(page).to have_content('expired')
      end
    end
  end
end
