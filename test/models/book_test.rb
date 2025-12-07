require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "requires a name" do
    book = Book.new(name: nil)
    assert_not book.valid?
  end

  test "average_score returns 0 when no reviews exist" do
    book = Book.create!(name: "Test Book")
    assert_equal 0.0, book.average_score
  end

  test "average_score calculates correctly" do
    book = Book.create!(name: "Calc Book")

    user1 = User.create!(
      email: "a@a.com",
      password: "StrongPass123!",
      password_confirmation: "StrongPass123!",
      date_of_birth: 20.years.ago.to_date
    )

    user2 = User.create!(
      email: "b@b.com",
      password: "StrongPass123!",
      password_confirmation: "StrongPass123!",
      date_of_birth: 25.years.ago.to_date
    )

    Review.create!(book: book, user: user1, title: "A", description: "AAA", score: 5)
    Review.create!(book: book, user: user2, title: "B", description: "BBB", score: 3)

    assert_equal 4.0, book.average_score
  end
end
