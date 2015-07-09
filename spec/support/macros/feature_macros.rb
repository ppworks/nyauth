module FeatureMacros
  def sign_in(client)
    serializer = Nyauth::SessionSerializer.new({})
    as = client.class.name.demodulize.underscore
    session_key = serializer.key_for(as)
    session_value = serializer.serialize(client)
    page.set_rack_session(session_key => session_value)
  end
end
