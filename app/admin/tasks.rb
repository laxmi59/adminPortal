ActiveAdmin.register Task do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :project_id, :admin_user_id, :title, :is_done, :due_date
  #
  # or
  #
  # permit_params do
  #   permitted = [:project_id, :admin_user_id, :title, :is_done, :due_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  scope :all, :default => true
  scope :due_this_week do |tasks|
    tasks.where('due_date > ? and due_date < ?', Time.now, 1.week.from_now)
  end
  scope :late do |tasks|
    tasks.where('due_date < ?', Time.now)
  end
  scope :mine do |tasks|
    tasks.where(:admin_user_id => current_admin_user.id)
  end

  show do
    panel "Task Details" do
      attributes_table_for task do
        #row("Status") { status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
        row("Status") { task.is_done ? status_tag("Done", class: :ok) : status_tag("Pending", class: :error)}
        row("Title") { task.title }
        row("Project") { link_to task.project.title, admin_project_path(task.project) }
        row("Assigned To") { link_to task.admin_user.email, admin_admin_user_path(task.admin_user) }
        row("Due Date") { task.due_date? ? l(task.due_date, :format => :long) : '-' }
      end
    end

    active_admin_comments
  end

  sidebar "Other Tasks For This User", :only => :show do
    table_for current_admin_user.tasks.where(:project_id => task.project) do |t|
      #t.column("Status") { |task| status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
      t.column("Status") { |task| task.is_done ? status_tag("Done", class: :ok) : status_tag("Pending", class: :ok) }
      t.column("Title") { |task| link_to task.title, admin_task_path(task) }
    end
  end

end
