require 'rails_helper'

describe 'UserAuthenticator' do
  describe 'perform' do
    context 'when code is incorrrect' do
      it 'should raise an error' do
        authenticator = UserAuthenticator.new('sample code')
        expect{ authenticator.perform }.to raise_error(
          UserAuthenticator::AuthenticationError)
        expect(authenticator.user).to be_nil
      end
    end

  end
end
