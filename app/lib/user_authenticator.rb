class UserAuthenticator
  class AuthenticationError < StandardError; end

  attr_reader :user

  def initialize(code)
    @code = code
  end

  def perform
    if token.try(:error).present?
      raise AuthenticationError
    else
      prepare_user
    end
  end

  private

  def client
    @client ||= Octokit::Client.new(
      client_id: ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET']
    )
  end

  def token
    @token ||= client.exchange_code_for_token(code)
  end

  def user_data
    @user_date =  Octokit::Client.new(
      access_token: token).user.to_h.
      slice(:login, :avatar_url, :url, :name)
  end

  def prepare_user
    @user = if User.exists?(login: user_data[:login])
      User.find_by(login: user_data[:login])
    else
      User.create(user_data.merge(provider: 'github'))
    end
  end

  attr_reader :code
end
