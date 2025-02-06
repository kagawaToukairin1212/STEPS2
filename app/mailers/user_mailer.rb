class UserMailer < ApplicationMailer
  default from: "notifications@example.com"

  def welcome_email
    @user = params[:user]

    if @user.nil?
      Rails.logger.error "UserMailer: user is nil. Cannot send email."
      return
    end

    @url = "http://example.com/login"
    mail(to: @user.email, subject: "私の素敵なサイトへようこそ")
  end
end