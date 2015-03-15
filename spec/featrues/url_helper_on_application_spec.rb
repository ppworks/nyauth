require 'rails_helper'

RSpec.describe 'URL helper on Application' do
  feature 'get path on engine' do
    scenario 'can use URL helper on application' do
      visit nyauth.new_session_path
      expect(page).to have_link('URL helper on application')
    end
  end
end
