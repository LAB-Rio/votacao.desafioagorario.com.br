# users/registrations_controller.rb
class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  
  def create 
    @user = User.find_or_initialize_by(signin_params)


    if @user.new_record? || !@user.confirmed?
      @user.save! if @user.new_record?

      respond_with resource, location: confirmation_message_path
    else
      sign_in('user', @user)
      respond_with resource, location: after_sign_in_path_for(resource)
    end

    #self.resource = warden.authenticate!(auth_options)
    #set_flash_message(:notice, :signed_in) if is_flashing_format?
    #yield resource if block_given?
  end


  def signin_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
