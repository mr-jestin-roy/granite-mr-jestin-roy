class Task < ApplicationRecord
  MAX_TITLE_LENGTH = 125
  validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH }
end
