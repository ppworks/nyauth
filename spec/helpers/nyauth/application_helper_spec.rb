require 'rails_helper'

RSpec.describe Nyauth::ApplicationHelper do
  describe '#session_path_for' do
    subject { helper.session_path_for(nyauth_client_name) }

    context 'when nyauth_client_name is admin' do
      let(:nyauth_client_name) { :admin }
      it { is_expected.to eq '/admin/session' }
    end

    context 'when nyauth_client_name is user' do
      let(:nyauth_client_name) { :user }
      it { is_expected.to eq '/session' }
    end
  end

  describe '#new_session_path_for' do
    subject { helper.new_session_path_for(nyauth_client_name) }

    context 'when nyauth_client_name is admin' do
      let(:nyauth_client_name) { :admin }
      it { is_expected.to eq '/admin/session/new' }
    end

    context 'when nyauth_client_name is user' do
      let(:nyauth_client_name) { :user }
      it { is_expected.to eq '/session/new' }
    end
  end

  describe '#registration_path_for' do
    subject { helper.registration_path_for(nyauth_client_name) }

    context 'when nyauth_client_name is admin' do
      let(:nyauth_client_name) { :admin }
      it { is_expected.to be_blank }
    end

    context 'when nyauth_client_name is user' do
      let(:nyauth_client_name) { :user }
      it { is_expected.to eq '/registration' }
    end
  end

  describe '#new_registration_path_for' do
    subject { helper.new_registration_path_for(nyauth_client_name) }

    context 'when nyauth_client_name is admin' do
      let(:nyauth_client_name) { :admin }
      it { is_expected.to be_blank }
    end

    context 'when nyauth_client_name is user' do
      let(:nyauth_client_name) { :user }
      it { is_expected.to eq '/registration/new' }
    end
  end

  describe '#password_path_for' do
    subject { helper.password_path_for(nyauth_client_name) }

    context 'when nyauth_client_name is admin' do
      let(:nyauth_client_name) { :admin }
      it { is_expected.to eq "/admin/password" }
    end

    context 'when nyauth_client_name is user' do
      let(:nyauth_client_name) { :user }
      it { is_expected.to eq "/password" }
    end
  end

  describe '#new_confirmation_request_path_for' do
    subject { helper.new_confirmation_request_path_for(nyauth_client_name) }

    context 'when nyauth_client_name is admin' do
      let(:nyauth_client_name) { :admin }
      it { is_expected.to be_blank }
    end

    context 'when nyauth_client_name is user' do
      let(:nyauth_client_name) { :user }
      it { is_expected.to eq "/confirmation_requests/new" }
    end
  end

  describe '#confirmation_path_for(:confirmation_key)' do
    subject { helper.confirmation_path_for(nyauth_client_name, confirmation_key) }
    let(:confirmation_key) { 'hogehoge' }

    context 'when nyauth_client_name is admin' do
      let(:nyauth_client_name) { :admin }
      it { is_expected.to be_blank }
    end

    context 'when nyauth_client_name is user' do
      let(:nyauth_client_name) { :user }
      it { is_expected.to eq "/confirmations/#{confirmation_key}" }
    end
  end

  describe '#reset_password_requests_path_for' do
    subject { helper.reset_password_requests_path_for(nyauth_client_name) }

    context 'when nyauth_client_name is admin' do
      let(:nyauth_client_name) { :admin }
      it { is_expected.to eq "/admin/reset_password_requests" }
    end

    context 'when nyauth_client_name is user' do
      let(:nyauth_client_name) { :user }
      it { is_expected.to eq "/reset_password_requests" }
    end
  end

  describe '#new_reset_password_request_path_for' do
    subject { helper.new_reset_password_request_path_for(nyauth_client_name) }

    context 'when nyauth_client_name is admin' do
      let(:nyauth_client_name) { :admin }
      it { is_expected.to eq "/admin/reset_password_requests/new" }
    end

    context 'when nyauth_client_name is user' do
      let(:nyauth_client_name) { :user }
      it { is_expected.to eq "/reset_password_requests/new" }
    end
  end

  describe '#reset_password_path_for(:reset_password_key)' do
    subject { helper.reset_password_path_for(nyauth_client_name, reset_password_key) }
    let(:reset_password_key) { 'hogehoge' }

    context 'when nyauth_client_name is admin' do
      let(:nyauth_client_name) { :admin }
      it { is_expected.to eq "/admin/reset_passwords/#{reset_password_key}" }
    end

    context 'when nyauth_client_name is user' do
      let(:nyauth_client_name) { :user }
      it { is_expected.to eq "/reset_passwords/#{reset_password_key}" }
    end
  end
end
