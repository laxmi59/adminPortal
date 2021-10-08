ActiveAdmin.register Category do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :name, :parent_category_id, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :parent_category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  config.sort_order = 'id_asc'
  csv do
    column :id
    column("Category") { |cat| cat.name }
    column :parent_category
    column :image
  end

  form html: { multipart: true }  do |f|
    f.inputs  do
      f.input :name
      f.input :parent_category_id, :as => :select, :collection => Category.where("parent_category_id is null")
      f.input :image, as: :file
      if category.image.url
        panel "Image" do
          image_tag(category.image.url(:medium))
        end
      end
    end
    f.actions
  end

  scope :all, :default => true
  scope "Main Categories" do |cat|
    cat.where("parent_category_id is null")
  end
  scope "Sub Categories" do |cat|
    cat.where("parent_category_id > ?", 0)
  end

  index do
    render 'admin/categories/index', context: self
  end

  show do
    render 'admin/categories/show', context: self
  end
end
