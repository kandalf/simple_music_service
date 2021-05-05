class Album < ApplicationRecord
  validates :name, presence: true
  validates :total_duration, numericality: true
  validates :year, presence: true, numericality: true
end
