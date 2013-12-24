class SessionsController < ApplicationController
    before_filter :require_login, only: [:destroy]

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email])
        if user && user.authenticate(params[:session][:password])
            sign_in user
            redirect_to root_url, :notice => "Successfully signed in"
        else
            flash.alert = "Invalid Login Credentials"
            render "new"
        end
    end

    def destroy
        sign_out
        flash.now[:notice] = "Successfully Signed Out"
        redirect_to root_url
    end
end
