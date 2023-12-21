ActiveAdmin.register Member do
  permit_params :last_name, :first_name, :email, :password, :reset_password_token,
                :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at,
                :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip

  index do
    selectable_column
    id_column
    column :last_name
    column :first_name
    column :email
    column :sign_in_count
    column :created_at
    column :updated_at
    column :reset_password_sent_at
    column :remember_created_at
    column :current_sign_in_at
    column :last_sign_in_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :last_name
      f.input :first_name
      f.input :email
      f.input :password
    end
    f.actions
  end
end
