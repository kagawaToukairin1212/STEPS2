class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to mypage_path, success: 'user_sessions.create.success'
    else
      flash.now[:danger] = 'user_sessions.create.failure'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: 'user_sessions.destroy.success'
  end
end

