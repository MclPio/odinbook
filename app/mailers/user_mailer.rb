class UserMailer < ApplicationMailer
  default from: 'notifications@odinbook.com'

  def welcome_email(user)
    @user = user
    @url = 'https://mclpio-odinbook.fly.dev/'
    @site_name = 'Odinbook'
    mail(to: user.email, subject: 'Welcome to Odinbook')
  end
end
