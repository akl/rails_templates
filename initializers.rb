# initializers.rb
# definiert zus. initializer-files


#====================
# INITIALIZERS
#====================
initializer 'action_mailer_configs.rb',
%q{ActionMailer::Base.smtp_settings = {
  :address            => 'host.mail.tld',
  :port               => 25,
  :domain             => 'domain.tld',
  :authentication     => :login,
  :user_name          => 'recipient@domain.tld',
  :password           => 'pass'
}
}
