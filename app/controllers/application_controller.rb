class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Sie haben leider keine Berechtigung diese Seite zu sehen"

    if user_signed_in?
      redirect_to root_url
    else
      session['user_return_to'] = request.fullpath
      redirect_to new_user_session_path
    end
  end

  def layout_by_resource
    if current_user.nil?
       "layout_devise"
    else
       "application"
    end
  end
end
