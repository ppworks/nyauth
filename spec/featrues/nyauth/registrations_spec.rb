require 'rails_helper'

RSpec.describe 'Nyauth::Registrations' do
  let(:user) { build(:user) }

  feature 'register' do
    background { visit nyauth.new_registration_path }

    scenario 'create user' do
      fill_in('user_email', with: user.email)
      fill_in('user_password', with: user.password)
      fill_in('user_password_confirmation', with: user.password)
      click_button('Sign up')

      expect(page).to have_content('registration success')
    end

    scenario "can't create user" do
      click_button('Sign up')

      expect(page).to have_content('errors')
    end
  end
end
