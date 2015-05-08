# users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      save_path(proposals: { user_proposals: session[:proposal_ids] })
    end

    def after_update_path_for(resource)
      save_path(proposals: { user_proposals: session[:proposal_ids] })
    end
end
