ActionMailer::Base.smtp_settings = {
  address:                'smtp.mandrillapp.com',
  port:                   '587',                
  enable_starttls_auto:   true,
  user_name:              ENV['email_username'],
  password:               ENV['email_password'],
  authentication:         :login,
 domain: 'codecore-events.herokuapp.com'
}
