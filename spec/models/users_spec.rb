require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(20) }
  end

  describe 'association' do
    it { should have_many(:posts) }

    it { should have_many(:comments).dependent(:destroy) }

    it { should have_many(:likes).dependent(:destroy) }

    it { should have_many(:friendships) }

    it { should have_many(:confirmed_friendships).class_name('Friendship') }

    it { should have_many(:friends).through(:confirmed_friendships) }

    it { should have_many(:pending_friendships).class_name('Friendship').with_foreign_key('user_id') }

    it { should have_many(:pending_friends).through(:pending_friendships).source(:friend) }

    it { should have_many(:inverted_friendships).class_name('Friendship').with_foreign_key('friend_id') }

    it { should have_many(:friend_requests).through(:inverted_friendships).source(:user) }
  end

  describe '#Friendships' do
    let(:sender) { create(:user) }

    let(:receiver) { create(:user) }

    let(:true_friendship) do
      Friendship.new(
        user: sender,
        friend: receiver,
        confirmed: true
      )
    end

    let(:false_friendship) do
      Friendship.new(
        user: sender,
        friend: receiver,
        confirmed: false
      )
    end

    it '#friends' do
      true_friendship.save
      expect(sender.friends).to include(receiver)
    end

    it '#friend?' do
      true_friendship.save
      expect(sender.user_friend?(receiver)).to be(true)
    end

    it '#pending_friends' do
      false_friendship.save
      expect(sender.user_pending_friends?(receiver)).to be(true)
    end

    it '#friend_request' do
      false_friendship.save
      expect(receiver.user_friend_requests?(sender)).to be(true)
    end
  end
end
