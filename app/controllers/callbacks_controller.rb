class CallbacksController < ApplicationController
  def github
    omniauth_data = request.env["omniauth.auth"]
    user = User.find_github_user(omniauth_data)
    user ||= User.create_from_github(omniauth_data)
    sign_in(user)
    redirect_to root_path, notice: "Signed In!"
  end
end
