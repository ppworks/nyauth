RSpec.shared_examples 'Nyauth::SessionConcern' do
  describe '#sign_in' do
    subject { controller.__send__(:sign_in, user) }

    context 'as user' do
      let(:options) { { as: :user } }

      context 'given user' do
        let(:user) { create(:user) }
        it '#signed_in? should change result from false to true 'do
          expect {
            subject
          }.to change { controller.__send__(:signed_in?, options) }.from(false).to(true)
        end

        it '#signed_in?(as: :admin) should not change result from false'do
          expect {
            subject
          }.not_to change { controller.__send__(:signed_in?, as: :admin) }.from(false)
        end

        it '#current_authenticated should change from result nil to user 'do
          expect {
            subject
          }.to change { controller.__send__(:current_authenticated) }.from(nil).to(user)
        end
      end

      context 'given nil' do
        let(:user) { nil }
        it '#signed_in? should not change result from false'do
          expect {
            subject
          }.not_to change { controller.__send__(:signed_in?, options) }.from(false)
        end

        it '#current_authenticated should not change result from nil'do
          expect {
            subject
          }.not_to change { controller.__send__(:current_authenticated) }.from(nil)
        end
      end
    end
  end
end
