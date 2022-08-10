# frozen_string_literal: true

class Question < ApplicationRecord
  # Validations
  validates_presence_of :title, :body

  # Associations
  belongs_to :user
  # Associations
  has_many :answers, dependent: :destroy

  # Scope
  scope :with_user_details, -> {
    joins(:user).select('questions.*', 'users.email as asked_by', 'users.id as asked_by_id' )
  }
end
