# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, :content, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :recent, -> { order(created_at: :desc) }
end
