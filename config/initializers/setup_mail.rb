ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "high-water-510.heroku.com",
  :user_name            => "devtest.rubyist@gmail.com",
  :password             => "strong123",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "high-water-510.heroku.com"
