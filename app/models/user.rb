# frozen_string_literal: true

class User < ApplicationRecord
  # Validations
  validates_presence_of :email, :password
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_confirmation_of :password
  has_secure_password :password

  # Associations
  has_many :questions, dependent: :destroy
end
