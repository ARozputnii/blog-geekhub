ActiveAdmin.register Author do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :first_name, :last_name, :gender, :birthday, :email, :password_digest, :baned
  #
  # or
  #
  permit_params do
    permitted = %i[first_name last_name gender birthday email baned]
    # permitted << :other if params[:action] == 'create' && current_user.admin?
    # permitted
  end
end
