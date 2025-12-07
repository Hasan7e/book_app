require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      email: "u@test.com",
      password: "StrongPass123!",
      password_confirmation: "StrongPass123!",
      date_of_birth: 20.years.ago.to_date
    )

    @book = Book.create!(name: "Review Book")
  end

  test "valid review" do
    review = Review.new(
      title: "Great",
      description: "Amazing read",
      score: 5,
      user: @user,
      book: @book
    )
    assert review.valid?
  end

  test "requires title" do
    review = Review.new(description: "Nice", score: 4, user: @user, book: @book)
    assert_not review.valid?
  end

  test "rejects duplicate review by same user" do
    Review.create!(
      title: "One",
      description: "Good",
      score: 4,
      user: @user,
      book: @book
    )

    dup = Review.new(
      title: "Two",
      description: "Better",
      score: 5,
      user: @user,
      book: @book
    )

    assert_not dup.valid?
  end
end
