# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [ :new ]
  before_action :set_book
  before_action :set_review, only: [ :edit, :update, :destroy ]
  before_action :authorize_owner!, only: [ :edit, :update, :destroy ]

  # If someone visits /books/:book_id/reviews/new, send them to the book page form
  def new
    redirect_to book_path(@book, anchor: "review-form")
  end

  def create
    @review = current_user.reviews.find_or_initialize_by(book: @book)
    if @review.update(review_params)
      redirect_to @book, notice: "Thanks! Your review has been saved."
    else
      @reviews = @book.reviews.includes(:user).order(created_at: :desc)
      render "books/show", status: :unprocessable_entity
    end
  end

  # Keep “edit” on the same page; just jump to the form
  def edit
    redirect_to book_path(@book, anchor: "review-form")
  end

  def update
    if @review.update(review_params)
      redirect_to @book, notice: "Your review has been updated."
    else
      @reviews = @book.reviews.includes(:user).order(created_at: :desc)
      render "books/show", status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to @book, notice: "Your review has been deleted."
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = @book.reviews.find(params[:id])
  end

  def authorize_owner!
    redirect_to @book, alert: "You can only modify your own review." unless @review.user == current_user
  end

  def review_params
    params.require(:review).permit(:title, :description, :score)
  end
end
