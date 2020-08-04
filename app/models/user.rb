class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 7..12 }
  # 漢字と全角の平仮名とカタカナのバリデーション
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
  validates :family_name, presence: true, format: { with: VALID_NAME_REGEX }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX }
  # 全角カタカナのバリデーション
  VALID_KANA_NAME_REGEX = /\A[ァ-ヶー－]+\z/
  validates :family_name_kana, presence: true, format: { with: VALID_KANA_NAME_REGEX }
  validates :first_name_kana, presence: true, format: { with: VALID_KANA_NAME_REGEX }
  has_one :delivery_address
end
