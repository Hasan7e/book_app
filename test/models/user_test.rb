require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user with strong password and valid age" do
    user = User.new(
      email: "user@example.com",
      password: "StrongPass123!",
      password_confirmation: "StrongPass123!",
      date_of_birth: 20.years.ago.to_date
    )
    assert user.valid?
  end

  test "rejects weak password" do
    user = User.new(
      email: "weak@example.com",
      password: "weak",
      password_confirmation: "weak",
      date_of_birth: 20.years.ago.to_date
    )
    assert_not user.valid?
  end

  test "rejects underage users" do
    user = User.new(
      email: "young@example.com",
      password: "StrongPass123!",
      password_confirmation: "StrongPass123!",
      date_of_birth: 10.years.ago.to_date
    )
    assert_not user.over16?
  end
end
