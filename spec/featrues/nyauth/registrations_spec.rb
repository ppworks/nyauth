require 'rails_helper'

RSpec.describe 'Nyauth::Registrations' do
  let(:user) { build(:user) }

  feature 'register' do
    background { visit nyauth.new_registration_path }

    scenario 'create user' do
      fill_in('registration_email', with: user.email)
      fill_in('registration_password', with: user.password)
      fill_in('registration_password_confirmation', with: user.password)
      click_button(I18n.t('nav.nyauth.registrations.new'))

      expect(page).to have_content('registration success')
      expect(User.last.email).to eq user.email
    end

    scenario "can't create user" do
      click_button(I18n.t('nav.nyauth.registrations.new'))

      expect(page).to have_content("can't")
    end
  end
end
