require 'rails_helper' 
describe '#create' do
  it "is valid with nickname,email,password,password_confirmation, family_name,first_name, family_name_kana,first_name_kana,birthday,phone" do
    user = build(:user)
    expect(user).to be_valid
  end

  describe ':nickname' do
    it "is invalid without nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
  end

  describe ':email' do
    it "is invalid without email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user)
      another_user.invalid?
      expect(another_user.errors[:email]).to include ("はすでに存在します")
    end
  end

  describe ':password' do
    it "is invalid without password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
  #   it "is invalid without more than 6 characters" do
  #     user = build(:user, password: "ngtest")
  #     user.valid?
  #     binding.pry
  #     expect(user.errors[:password]).to include("は6以上の値にしてください")
  #   end
  end

  describe ':password_confirmation' do

    it "is invalid without match password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

  end

  describe ':family_name' do
    it "is invalid without family_name" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end
  end

  describe ':first_name' do
    it "is invalid without first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end
  end

  describe ':family_name_kana' do
    it "is invalid without family_name_kana" do
      user = build(:user, family_name_kana: "")
      user.valid?
      expect(user.errors[:family_name_kana][0]).to include("を入力してください")
    end
    it "is invalid unless using p{katakana}" do
      user = build(:user, family_name_kana: "てすと")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("カタカナで入力してください")
    end
  end

  describe ':first_name_kana' do
    it "is invalid without first_name_kana" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana][0]).to include("を入力してください")
    end
    it "is invalid  unless using p{katakana}" do
      user = build(:user, first_name_kana: "太郎")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("カタカナで入力してください")
    end
  end

  describe ':birthday' do
    it "is invalid without birthday" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end
    it "is invalid without past_day" do
      day = Date.today
      user = build(:user, birthday: day)
      user.valid?
      expect(user.errors[:birthday]).to include("正しい日付を入力してください")
    end
  end

  describe ':phone' do
    it "is invalid without phone" do
      user = build(:user, phone: "")
      user.valid?
      expect(user.errors[:phone]).to include("を入力してください")
    end
    it "is invalid without /0[89]0-?\d{4}-?\d{4}/ " do
      user = build(:user, phone: "0312345678")
      user.valid?
      expect(user.errors[:phone]).to include("正しい電話番号を入力してください")
    end
  end
  
end