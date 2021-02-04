require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'association' do
    it { should belong_to(:user) }

    it { should belong_to(:friend).class_name('User') }
  end

  describe 'friendship' do
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

    it '#confirm_friend' do
      false_friendship.save
      expect(receiver.inverted_friendships.confirm_friend(sender)).to be(true)
    end

    it '#reject_friend' do
      false_friendship.save
      expect(receiver.inverted_friendships.reject_friend(sender)).to be_kind_of(Friendship)
    end
  end
end
