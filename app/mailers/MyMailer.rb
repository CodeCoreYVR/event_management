class MyMailer < ActionMailer::Base
	def confirmation_email(user)
		@user = user

		mail(to: user.email,
			   From: 'brandontricci@gmail.com' 
			   Subject: 'Confirmation Email From CodeCore Events')
	end
end
