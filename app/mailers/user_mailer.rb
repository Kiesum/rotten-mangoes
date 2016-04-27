class UserMailer < ActionMailer::Base
  default from: "admin@rottenmangoes.com"

  def account_delete_email(user)
    @user = user
    mail(to: @user.email, subject: 'Removal from Rotten Mangoes')
  end

end
