class HomeController < ApplicationController
    def welcome
        if current_user and current_user.role == 'Admin'
            render :layout => 'admin'
        elsif current_user and current_user.role == 'User'
            render :layout => 'user'
        else
        end
    end
end