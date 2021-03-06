# users/registrations_controller.rb
class Users::ConfirmationsController < Devise::ConfirmationsController

  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource_name, resource)
    save_path(proposals: { user_proposals: session[:proposal_ids] })
  end
end
