require 'rails_helper'

RSpec.describe 'Nyauth::Passwords' do
  let(:user) { create(:user) }

  feature 'password' do
    let(:new_password) { 'cool_password' }
    background do
      sign_in(user)
      visit nyauth.edit_password_path
    end

    scenario 'update password' do
      fill_in('user_password', with: new_password)
      fill_in('user_password_confirmation', with: new_password)
      click_button(I18n.t('nav.nyauth.common.update'))

      expect(page).to have_content('updated')
    end

    scenario "can't udpate password" do
      click_button(I18n.t('nav.nyauth.common.update'))

      expect(page).to have_content("can't")
    end
  end
end
