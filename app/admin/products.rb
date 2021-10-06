ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :category_id, :brand_id, :pack_size, :price, :body, {productimages: []}
  form html: { multipart: true }  do |f|
    f.inputs  do
      f.input :name
      f.input :category_id, :as => :select, :collection => Category.all
      f.input :brand_id, :as => :select, :collection => Brand.all
      f.input :pack_size
      f.input :price
      f.input :body
      f.input :productimages, as: :file, input_html: { multiple: true }
      # if product.productimages
      #   prodimg = []
      #   columns :productimages do |images|
      #     product.productimages.each do |imgs|
      #       #puts imgs.url(:medium)
      #       prodimg << image_tag(imgs.url(:medium))
      #     end
      #     #puts prodimg.inspect
      #   end
      #   prodimg
      # end
    end
    f.actions
  end


  index do
    column :id
    column :name
    column :parent_category
    column("Category"){ |cat| cat.name}
    column("Brand"){|brand| brand.name}
    column :price
    column :body
    #column :productimages
    column :productimages do |images|
      s = []
      images.productimages.each do |imgs|
        #image_tag(imgs.url)
        s << image_tag(imgs.url(:thumb))
      end
      s
    end
    actions
  end
  show do
    s = []
    panel "Product Details" do
      attributes_table_for product do
        #puts product.category.inspect
        row("Product Name") { product.name }
        row("Parent Category") { product.category.parent_category}
        row("Category") { product.category }
        row("Brand") { product.brand }
        row("Pack Size") { product.pack_size }
        row("Price") { product.price }
        row("Body") { product.body }
        row("Productimages") {
          |prod| prod.productimages.each do |imgs|
            #puts imgs.url
            s << image_tag(imgs.url(:medium))
          end
          s
         }
        row("Created At") { product.created_at }
        row("Updated At") { product.updated_at }
      end
    end
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :category_id, :brand_id, :pack_size, :price, :body, :productimages]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
