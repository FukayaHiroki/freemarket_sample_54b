require 'rails_helper'
describe Comment do
  describe '#create' do
    it "is invalid without a content" do
      comment = Comment.new(content: "", product_id: 1, user_id: 1)
      comment.valid?
      expect(comment.errors[:content]).to include("を入力してください")
    end
  end
end