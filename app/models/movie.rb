class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates_presence_of :title, :description
end
