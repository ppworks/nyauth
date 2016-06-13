require 'rails_helper'

RSpec.describe Nyauth::BaseController do
  context 'when nyauth parent_controller is default(=ApplicationController)' do
    it_behaves_like 'Nyauth::SessionConcern'
  end

  context 'when nyauth parent_controller is another controller' do
    before { Nyauth.configuration.parent_controller = 'AnotherApplicationController' }

    it_behaves_like 'Nyauth::SessionConcern'
  end
end
