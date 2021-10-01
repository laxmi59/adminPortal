ActiveAdmin.register Category do

scope :all, :default => true
scope "Main Categories" do |cat|
  cat.where("parent_category_id is null")
end
scope "Sub Categories" do |cat|
  cat.where("parent_category_id > ?", 0)
end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :parent_category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :parent_category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
