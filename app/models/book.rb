class Book < ApplicationRecord
    has_many :reviews, dependent: :destroy
    validates :name, presence: true
  
    def average_score
      return 0.0 if reviews.empty?
      reviews.average(:score).to_f.round(1)
    end
  end
  
