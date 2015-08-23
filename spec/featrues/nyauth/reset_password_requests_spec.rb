require 'rails_helper'

RSpec.describe 'Nyauth::NewPasswordRequests' do
  let!(:user) { create(:user) }

  feature 'confirmation' do
    let(:reset_password) { 'cool_password' }
    background do
      visit nyauth.new_reset_password_request_path
    end

    scenario 'request & set reset password' do
      fill_in('reset_password_request_email', with: user.email)
      click_button(I18n.t('nav.nyauth.common.send'))

      open_email(user.email)
      current_email.click_link('set new password')

      fill_in('user_password', with: reset_password)
      fill_in('user_password_confirmation', with: reset_password)
      click_button(I18n.t('nav.nyauth.common.set'))

      expect(page).to have_content('updated')
      expect(current_path).to eq nyauth.new_session_path
    end

    scenario 'request expired' do
      fill_in('reset_password_request_email', with: user.email)
      click_button(I18n.t('nav.nyauth.common.send'))

      Timecop.freeze(Time.current + 3.hours) do
        open_email(user.email)
        current_email.click_link('set new password')

        expect(page).to have_content('expired')
      end
    end
  end
end
