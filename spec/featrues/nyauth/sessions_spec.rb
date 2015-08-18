require 'rails_helper'

RSpec.describe 'Nyauth::Sessions' do
  context 'user' do
    let(:user) { create(:user) }
    feature 'sign in' do
      background { visit nyauth.new_session_path }

      scenario 'sign in user' do
        fill_in('session_email', with: user.email)
        fill_in('session_password', with: user.password)
        click_button('Sign in')

        expect(page).to have_content('sign in success')
      end

      scenario "can't sign in user" do
        click_button('Sign in')

        expect(page).to have_content('Invalid')
      end
    end

    feature 'sign in & redirect to page accessed before sign in' do
      background { visit posts_path }

      scenario 'sign in user' do
        fill_in('session_email', with: user.email)
        fill_in('session_password', with: user.password)
        click_button('Sign in')

        expect(page).to have_content('sign in success')
        expect(current_path).to eq posts_path
      end
    end

    feature 'sign out' do
      background do
        sign_in(user)
      end

      scenario 'sign out user' do
        visit root_path
        click_link('Sign out')
        expect(page).to have_content('sign out')

        sign_out
        visit root_path
        expect(page).not_to have_content('sign out')
      end
    end
  end

  context 'admin' do
    let(:admin) { create(:admin) }
    feature 'sign in' do
      background { visit new_admin_session_path }

      scenario 'sign in admin' do
        fill_in('session_email', with: admin.email)
        fill_in('session_password', with: admin.password)
        click_button('Sign in')

        expect(page).to have_content('sign in success')
      end

      scenario "can't sign in admin" do
        click_button('Sign in')

        expect(page).to have_content('Invalid')
      end

    end

    feature 'sign out' do
      background do
        sign_in(admin)
      end

      scenario 'sign out admin' do
        visit root_path
        click_link('Sign out')
        expect(page).to have_content('sign out')

        sign_out
        visit root_path
        expect(page).not_to have_content('sign out')
      end
    end
  end
end
