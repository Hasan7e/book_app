require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
  end

  test "visiting the index" do
    visit books_url

    # Your real page title, NOT scaffold "Books"
    assert_selector "h1", text: "Read something that really cross your mind?"
  end

  test "viewing a book" do
    visit book_url(@book, anchor: "review-form")

    # Your UI shows the book name
    assert_text @book.name
  end
end
