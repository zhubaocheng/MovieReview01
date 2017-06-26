class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates_presence_of :title, :description
  has_many :moviee_relationships
  has_many :members, through: :movie_relationships, source: :user

end
