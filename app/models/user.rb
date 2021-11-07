class User < ApplicationRecord
  validates :login, presence: true, uniqueness: true
  validates :provider, presence: true

  has_one :access_token, dependent: :destroy
  # client secret: e5d940229b9068416d62036de2e3ada06c84a627
  # client id: c852ad4579e7e2c62995
end
