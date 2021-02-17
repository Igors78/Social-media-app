require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(name: 'James Bond')
  end

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }

    it { should have_many(:friend_requests_sent).class_name(:Friendship) }
    it { should have_many(:friend_requests_received).class_name(:Friendship) }

    it { should have_many(:requests_sent_to).through(:friend_requests_sent) }
    it { should have_many(:requests_received_from).through(:friend_requests_received) }
  end

  describe 'validations' do
    it 'is not valid without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it { should validate_presence_of(:name) }
  end
end
