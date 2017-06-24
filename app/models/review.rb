class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  validates_presence_of :content

  scope :recent, -> { order("created_at DESC")}
end
