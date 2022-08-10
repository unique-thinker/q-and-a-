# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should have_secure_password(:password) }
end
