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
    column :productimages
    column :x do |images|
       s = []
        #image_t(img, size:"50x50")
        #image_tag(images.productimages[0].url, size:"50x50")

        images.productimages.each do |imgs|

          #image_tag(imgs.url)
          s << image_tag(imgs.url, size:"50x50")
        end
        #images.productimages.split(',')[0]
       s
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
