class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :address, :role])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :address, :role])
    end

    private
    # to authenticat admin 
    def auth_admin
        if user_signed_in? && current_user.role == "User"
            flash[:notice] = "Only Admin can edit or add Products"
            redirect_to root_path # halts request cycle
        end
    end 
end
