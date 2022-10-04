class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_voter

  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum :user_role, %i[user admin]
end
