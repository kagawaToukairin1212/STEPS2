require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it "名前・メール・パスワードがあれば有効" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "名前がないと無効" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "メールがないと無効" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "重複したメールアドレスは無効" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
    end
  end
end
