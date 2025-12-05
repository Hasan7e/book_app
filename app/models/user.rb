class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy

  def age
    return nil unless date_of_birth
    AgeGuard.age(date_of_birth, today: Time.zone.today)
  end

  def over16?
    AgeGuard.over?(date_of_birth, 16, today: Time.zone.today)
  end
end
