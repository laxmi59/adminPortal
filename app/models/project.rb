class Project < ApplicationRecord
  has_many :tasks
  accepts_nested_attributes_for :tasks, :allow_destroy => true
  validates :title, :presence => true
end
