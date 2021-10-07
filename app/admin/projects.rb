ActiveAdmin.register Project do
  permit_params :title, task_attributes: [:title, :is_done, :due_date]

  form do |f|
    inputs 'Project Details' do
      f.input :title
      f.inputs do
        f.has_many :tasks, heading: 'Tasks', allow_destroy: true do |t|
          t.input :title
        end
      end
      f.actions
    end
  end


  index do
    render 'admin/projects/index', context: self
  end

  show :title => :title do
    render 'admin/projects/show', context: self
  end

end
