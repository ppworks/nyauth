require 'rails_helper'

RSpec.describe Nyauth::Configuration do
  describe '#configure' do
    let(:redirect_path_after_sign_in) { '/posts' }
    before do
      # applicationの
      # config/initializers/nyauth.rb
      Nyauth.configure do |config|
        config.redirect_path do |urls|
          config.redirect_path_after_sign_in = redirect_path_after_sign_in
        end
      end
      # nyauthの
      # config/rotues.rbから呼ばれる
      Nyauth.configuration.setup_redirect_path
    end

    subject { Nyauth.configuration.redirect_path_after_sign_in }

    it { is_expected.to eq redirect_path_after_sign_in }
  end
end
