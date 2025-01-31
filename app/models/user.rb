class User < ApplicationRecord
  # Sorceryを使用した認証機能
  authenticates_with_sorcery!
  has_many :sheets, dependent: :destroy
  has_many :questions, dependent: :destroy

  # パスワード関連のバリデーション（新規作成または変更時のみ適用）
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # 名前（必須、255文字以内）
  validates :name, presence: true, length: { maximum: 255 }

  # メールアドレス（必須、一意性）
  validates :email, presence: true, uniqueness: true
end
