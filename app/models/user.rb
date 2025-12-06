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


  # Strong password policy
  validate :strong_password

  private

  def strong_password
    return if password.blank?  # Skip if Devise is not setting a password now

    errors.add(:password, "must be at least 12 characters long") if password.length < 12

    unless password =~ /[A-Z]/
      errors.add(:password, "must include at least one uppercase letter")
    end

    unless password =~ /[a-z]/
      errors.add(:password, "must include at least one lowercase letter")
    end

    unless password =~ /\d/
      errors.add(:password, "must include at least one number")
    end

    unless password =~ /[^A-Za-z0-9]/
      errors.add(:password, "must include at least one special character")
    end
  end
end
