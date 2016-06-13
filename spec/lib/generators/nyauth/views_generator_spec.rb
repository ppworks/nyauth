require 'rails_helper'
require 'generators/nyauth/views_generator'

describe Nyauth::ViewsGenerator, type: :generator do
  destination ::File.expand_path('../tmp/', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  describe 'rails g nyauth:views' do
    it 'creates a test views' do
      assert_file 'app/views/nyauth/confirmation_requests/new.html.erb'
      assert_file 'app/views/nyauth/confirmations/edit.html.erb'
      assert_file 'app/views/nyauth/passwords/edit.html.erb'
      assert_file 'app/views/nyauth/registrations/new.html.erb'
      assert_file 'app/views/nyauth/request_mailer/request_confirmation.html.erb'
      assert_file 'app/views/nyauth/request_mailer/request_confirmation.text.erb'
      assert_file 'app/views/nyauth/request_mailer/request_reset_password.html.erb'
      assert_file 'app/views/nyauth/request_mailer/request_reset_password.text.erb'
      assert_file 'app/views/nyauth/reset_password_requests/new.html.erb'
      assert_file 'app/views/nyauth/reset_passwords/edit.html.erb'
      assert_file 'app/views/nyauth/sessions/new.html.erb'
      assert_file 'app/views/layouts/nyauth/base.html.erb'
      assert_file 'app/views/layouts/nyauth/mailer.html.erb'
      assert_file 'app/views/layouts/nyauth/mailer.text.erb'
    end
  end
end
