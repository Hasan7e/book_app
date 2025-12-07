require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    @review = reviews(:one)
    @user = users(:one)

    # ensure user meets over16 validation
    @user.update!(date_of_birth: 20.years.ago.to_date)

    sign_in @user
  end

  test "should redirect new to book page" do
    get new_book_review_url(@book)
    assert_redirected_to book_url(@book, anchor: "review-form")
  end

  test "should create review" do
    other_user = User.create!(
      email: "newuser@example.com",
      password: "Password123!",
      date_of_birth: 20.years.ago.to_date
    )

    sign_in other_user

    assert_difference("Review.count", 1) do
      post book_reviews_url(@book), params: {
        review: {
          title: "New Review",
          description: "Something",
          score: 4
        }
      }
    end

    assert_redirected_to book_url(@book)
  end


  test "should get edit (redirect)" do
    get edit_book_review_url(@book, @review)
    assert_redirected_to book_url(@book, anchor: "review-form")
  end

  test "should update review" do
    patch book_review_url(@book, @review), params: {
      review: { title: "Updated" }
    }

    assert_redirected_to book_url(@book)
  end

  test "should destroy review" do
    assert_difference("Review.count", -1) do
      delete book_review_url(@book, @review)
    end

    assert_redirected_to book_url(@book)
  end
end
