class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end


# 1. Configure the mailer to create full URLs in emails:

#     # config/environments/{development,test}.rb
#     config.action_mailer.default_url_options = { host: 'localhost:3000' }

#     In production it should be your app's domain name.