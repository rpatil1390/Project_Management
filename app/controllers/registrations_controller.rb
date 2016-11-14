class RegistrationsController < Devise::RegistrationsController
	def create
		@user = User.new(user_params)
        # abort @user.inspect

	    respond_to do |format|
	      if @user.save
            UserMailer.welcome_email(@user).deliver_later
	        format.html { redirect_to(root_path, :notice => 'Member was successfully created.') }
	        format.xml  { render :xml => @user, :status => :created, :location => @user }
	      else
	        format.html { render :action => "new" }
	        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
	      end
	    end
	end

	private

  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password)
  end
end
