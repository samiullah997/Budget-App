class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }

  has_many :groups, foreign_key: :author_id, dependent: :destroy
  has_many :expenses, foreign_key: :author_id, dependent: :destroy
end
