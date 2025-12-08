require "application_system_test_case"

class ReviewsTest < ApplicationSystemTestCase
  include SystemTestAuthenticationHelpers
  setup do
    @book = books(:one)
    @user = users(:one)

    # Force-reset password to ensure Devise accepts it
    force_password!(@user)
    # Remove fixture review so tests behave predictably
    Review.where(book: @book, user: @user).destroy_all
  end

  test "visiting the book page shows review section" do
    sign_in_user
    visit book_url(@book, anchor: "review-form")
    assert_selector "div.card-header" # "Edit your review" or "Write a review"
  end

  test "should create review" do
    sign_in_user
    visit book_url(@book, anchor: "review-form")

    # Delete existing review if present
    if page.has_button?("Delete")
      accept_confirm { click_on "Delete" }
    end

    fill_in "Title", with: "New Review"
    fill_in "Description", with: "Amazing book!"
    fill_in "Score", with: 5

    if page.has_button?("Post review")
      click_button "Post review"
    else
      click_button "Update review"
      assert_text "Your review has been updated."
    end
  end

  test "should update review" do
    sign_in_user

    # Create a review first
    Review.create!(book: @book, user: @user, title: "Old", description: "Old desc", score: 3)

    visit books_url
    click_on "View details", match: :first

    fill_in "Title", with: "Updated Title"
    fill_in "Description", with: "Updated description"
    fill_in "Score", with: 5

    click_button "Update review"
    assert_text "Your review has been updated."
  end

  test "should delete review" do
    sign_in_user

    Review.create!(
      book: @book,
      user: @user,
      title: "To delete",
      description: "bye",
      score: 3
    )

    visit book_url(@book)

    page.execute_script("window.confirm = () => true")
    click_on "Delete"

    refute_text "To delete"
    refute_text "bye"
  end
end
