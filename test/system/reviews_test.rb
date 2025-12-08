require "application_system_test_case"

class ReviewsTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
    @user = users(:one)
  end

  def sign_in_user
    visit new_user_session_path
    fill_in "Email",    with: @user.email
    fill_in "Password", with: "Password123!"
    click_button "Log in"
  end

  test "visiting the book page shows review section" do
    sign_in_user
    visit book_url(@book)
    assert_selector "h4", text: "Reviews"
    assert_selector "div.card-header", text: "Write a review"
  end

  test "should create review" do
    sign_in_user
    visit book_url(@book)

    fill_in "Title",       with: "My Test Review"
    fill_in "Description", with: "This is a test review."
    fill_in "Score (1–5)", with: 4

    click_button "Post review"

    assert_text "Thanks! Your review has been saved."
    assert_text "My Test Review"
  end

  test "should update review" do
    sign_in_user

    # First create a review for this user
    visit book_url(@book)
    fill_in "Title",       with: "Original Title"
    fill_in "Description", with: "Original body"
    fill_in "Score (1–5)", with: 3
    click_button "Post review"

    # Now edit
    visit book_url(@book)
    fill_in "Title", with: "Updated Title"
    click_button "Update review"

    assert_text "Your review has been updated."
    assert_text "Updated Title"
  end

  test "should delete review" do
    sign_in_user

    # Create review
    visit book_url(@book)
    fill_in "Title",       with: "Title to Delete"
    fill_in "Description", with: "Delete Me"
    fill_in "Score (1–5)", with: 5
    click_button "Post review"

    # Delete review
    visit book_url(@book)
    click_on "Delete"

    assert_text "Your review has been deleted."
    assert_no_text "Title to Delete"
  end
end
