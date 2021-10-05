class Category < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent_category, :class_name => "Category", :optional => true

  has_many :products
end
