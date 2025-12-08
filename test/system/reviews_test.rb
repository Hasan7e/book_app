require "application_system_test_case"

class ReviewsTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
    @review = reviews(:one)
    @user = users(:one)
    sign_in @user
  end

  test "visiting the index" do
    visit book_path(@book)
    assert_selector "h1", text: @book.name
  end

  test "should create review" do
    visit book_path(@book)

    fill_in "Title", with: "New Review"
    fill_in "Description", with: "Amazing!"
    fill_in "Score", with: 5
    click_on "Submit Review"

    assert_text "Thanks! Your review has been saved."
  end

  test "should update review" do
    visit book_path(@book, anchor: "review-form")

    fill_in "Title", with: "Updated Review"
    click_on "Submit Review"

    assert_text "Your review has been updated."
  end

  test "should destroy review" do
    visit book_path(@book)
    click_on "Delete Review", match: :first

    assert_text "Your review has been deleted."
  end
end
