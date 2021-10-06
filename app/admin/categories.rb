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
  form html: { multipart: true }  do |f|
    f.inputs  do
      f.input :name
      f.input :parent_category_id, :as => :select, :collection => Category.all
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
    column :id
    column("Category") { |cat| cat.name }
    column :parent_category
    column :image do |catimg|
      #puts catimg.image
      catimg.image? ? image_tag(catimg.image.url(:thumb)) : image_tag("no_image.png", size:"50x50")
    end
    actions
  end

  show do
    panel "Category Details" do
      attributes_table_for category do
        row("Category") { category.name }
        if category.parent_category
          row("Perent Category") { category.parent_category }
        end
        row("Image") { category.image? ? image_tag(category.image.url(:medium)) : image_tag("no_image.png", size:"100x100") }
        row("Created At") { category.created_at }
        row("Updated At") { category.updated_at }
      end
    end
    active_admin_comments
  end
end
