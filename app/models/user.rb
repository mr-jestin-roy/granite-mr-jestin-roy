# frozen_string_literal: true

class User < ApplicationRecord
  has_many :assigned_tasks, foreign_key: :assigned_user_id, class_name: "Task"

  validates :name, presence: true, length: { maximum: 35 }
end
