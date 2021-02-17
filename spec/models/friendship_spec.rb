require 'rails_helper'

RSpec.describe Friendship, type: :model do
  subject do
    described_class.new(
      friend_id: ''
    )
  end
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end
end
