require 'rails_helper'

RSpec.describe Nyauth::ApplicationHelper do
  describe '#session_path_for' do
    subject { helper.session_path_for(client_name) }

    context 'when client_name is admin' do
      let(:client_name) { :admin }
      it { is_expected.to eq '/admin/session' }
    end

    context 'when client_name is user' do
      let(:client_name) { :user }
      it { is_expected.to eq '/session' }
    end
  end

  describe '#new_session_path_for' do
    subject { helper.new_session_path_for(client_name) }

    context 'when client_name is admin' do
      let(:client_name) { :admin }
      it { is_expected.to eq '/admin/session/new' }
    end

    context 'when client_name is user' do
      let(:client_name) { :user }
      it { is_expected.to eq '/session/new' }
    end
  end
end
