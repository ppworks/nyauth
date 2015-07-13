module FeatureMacros
  include Nyauth::SessionConcern

  def sign_in(client)
    Nyauth::Nyan.on_test_request do |nyauth_nyan|
      nyauth_nyan.session.store(client, client.class.name.demodulize.underscore)
    end
  end

  def sign_out
    Nyauth::Nyan.on_test_request do |nyauth_nyan|
      nyauth_nyan.session.session.clear
    end
  end
end
