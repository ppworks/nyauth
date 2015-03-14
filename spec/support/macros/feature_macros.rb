module FeatureMacros
  include Nyauth::SessionConcern

  def sign_in(client)
    session_value = signed_in_session_object(client)
    page.set_rack_session(signed_in_session_key => session_value)
  end
end
