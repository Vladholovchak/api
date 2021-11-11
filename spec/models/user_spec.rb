# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    let!(:user) { build :user }

    it 'tests that factory is valid' do
      expect(user).to be_valid
    end

    it 'validate presence of attributes' do
      invalid_user = build :user, login: nil, provider: nil
      expect(invalid_user).not_to be_valid
      expect(invalid_user.errors.messages[:login]).to include("can't be blank")
      expect(invalid_user.errors.messages[:provider]).to include("can't be blank")
    end

    it 'validate uniqueness of login' do
      user = create(:user)
      other_user = build :user, login: user.login
      expect(other_user).not_to be_valid
      other_user.login = 'newlogin'
      expect(other_user).to be_valid
    end
  end
end
