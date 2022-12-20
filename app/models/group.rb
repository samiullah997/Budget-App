class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }, uniqueness: { scope: :author, message: 'You have already Category with this name' }
  validates :icon, presence: true, length: { maximum: 50 }

  belongs_to :author, class_name: 'User'
  has_many :group_expenses, dependent: :destroy
  has_many :expenses, through: :group_expenses, dependent: :destroy
end
