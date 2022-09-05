# frozen_string_literal: true

class Comment < ApplicationRecord
  MAX_CONTENT_LENGTH = 511

  belongs_to :user # Each comment belongs to a single user
  belongs_to :task # Each comment belongs to a single task

  validates :content, presence: true, length: { maximum: MAX_CONTENT_LENGTH }
end
