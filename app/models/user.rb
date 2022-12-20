class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :password, presence: true, length: { maximum: 20 }

  has_many :groups, foreign_key: :author_id, dependent: :destroy
  has_many :expenses, foreign_key: :author_id, dependent: :destroy
end
