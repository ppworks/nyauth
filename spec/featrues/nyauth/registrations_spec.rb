require 'rails_helper'

RSpec.describe 'Nyauth::Registrations' do
  context 'user' do
    let(:user) { build(:user) }

    feature 'register' do
      background { visit nyauth.new_registration_path }

      scenario 'create user' do
        fill_in('user_email', with: user.email)
        fill_in('user_password', with: user.password)
        fill_in('user_password_confirmation', with: user.password)
        click_button('Sign up')

        expect(page).to have_content('registration success')
        expect(User.last.email).to eq user.email
      end

      scenario "can't create user" do
        click_button('Sign up')

        expect(page).to have_content('errors')
      end
    end
  end

  context 'admin' do
    let(:admin) { build(:admin) }

    feature 'register' do
      # FIXIME: use URL helper
      background { visit '/admin/registration/new' }

      scenario 'create admin' do
        fill_in('admin_email', with: admin.email)
        fill_in('admin_password', with: admin.password)
        fill_in('admin_password_confirmation', with: admin.password)
        click_button('Sign up')

        expect(page).to have_content('registration success')
        expect(Admin.last.email).to eq admin.email
      end
    end
  end
end
