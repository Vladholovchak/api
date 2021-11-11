# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  validates :title, :content, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :recent, -> { order(created_at: :desc) }
end
