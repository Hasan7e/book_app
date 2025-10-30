class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def new
    @review = current_user.reviews.find_by(book: @book) || @book.reviews.build
  end

  def create
    @review = @book.reviews.build(review_params.merge(user: current_user))
    if @review.save
      redirect_to @book, notice: "Thanks! Your review has been posted."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      redirect_to @book, notice: "Your review has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to @book, notice: "Your review has been deleted."
  end

  private
  def set_book; @book = Book.find(params[:book_id]); end
  def set_review; @review = @book.reviews.find(params[:id]); end
  def authorize_owner!; redirect_to @book, alert: "You can only modify your own review." unless @review.user == current_user; end
  def review_params; params.require(:review).permit(:title, :description, :score); end
end
