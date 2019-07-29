require 'rails_helper'
describe Comment do
  describe '#create' do
    it "is valid with a content" do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it "is invalid without a content" do
      comment = build(:comment, content: nil)
      comment.valid?
      expect(comment.errors[:content]).to include("を入力してください")
    end
  end
end