class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    return current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  def authorize    
     if !current_user
      flash[:error] = "Ops! You must sign in "
      redirect_to '/sign_in'
    end
  end

  def check_event_changing_permission
    if current_user.id != Event.find(params[:id]).user_id
      flash[:error] = "Only article can edit even"
      redirect_to root_path
    end
  end

end
