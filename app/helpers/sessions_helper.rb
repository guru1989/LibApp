module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    if(user.class.to_s == "Admin")
      session[:user_id] = "a"+user.id.to_s
    else
      session[:user_id] = "m"+user.id.to_s
    end
  end
  def current_user
    if(session[:user_id]==nil)
      @current_user = nil
    elsif session[:user_id][0] == "m"
      s = session[:user_id].to_s
  	  @current_user = Member.find_by(id: s[1..s.length])
    else
      s = session[:user_id].to_s
      @current_user = Admin.find_by(id: s[1..s.length])
    end
  end
 # def current_admin
  #  @current_admin ||= Admin.find_by(id: session[:user_id])
  #end
  def logged_in?
    if !(current_user.nil?) 
      current_user
    else
      nil
    end
  end
  def log_out
     session[:user_id] = nil
     @current_user = nil
  end
  def is_admin?
    current_user.class.to_s == 'Admin'
  end
end
