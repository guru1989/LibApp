class SessionsController < ApplicationController
  def new
    if logged_in?
        redirect_to current_user
    end
  end
  def create
    user = nil
    admin = Admin.find_by(email: params[:session][:email].downcase)
    member = Member.find_by(email: params[:session][:email].downcase)
    puts params[:session][:option].class
    puts params[:session][:option].to_s
    if(params[:session][:option]=="admin")
      user = admin
    else
      user = member
    end
    
    if user && user.password == (params[:session][:password])

      flash[:notice] = "Welcome, #{user.name} to LibSys!"
      log_in user
      redirect_to root_path
      # Log the user in and redirect to the user's show page.
    #elsif member && member.password == (params[:session][:password])
  	#	flash[:notice] = "Welcome Member to the LibSys!"
  	#	log_in member
  	#	redirect_to member
      # Log the user in and redirect to the user's show page.
    else
      flash.now[:notice] = 'Invalid email/password combination'
  	  render 'new'
  	end
  end
  def destroy
    log_out
    redirect_to root_path
  end
end
