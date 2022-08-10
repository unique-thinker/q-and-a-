# frozen_string_literal: true

class Answer < ApplicationRecord
  # Validations
  validates_presence_of :body

  # Associations
  belongs_to :question
  belongs_to :user

  # Scope
  scope :with_user_details, -> {
    joins(:user).select('answers.body', 'users.email as answered_by', 'users.id as answered_by_id' )
  }
end
