class Product < ApplicationRecord
  mount_uploaders :productimages, ProductimagesUploader
  serialize :productimages, JSON # If you use SQLite, add this line.
  belongs_to :category
  belongs_to :brand
end
