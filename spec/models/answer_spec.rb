# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to validate_presence_of(:body) }
  it { should belong_to(:question) }
  it { should belong_to(:user) }
end
