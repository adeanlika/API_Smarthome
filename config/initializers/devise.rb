Devise.setup do |config|
  # The e-mail address that mail will appear to be sent from
  # If absent, mail is sent from "please-change-me-at-config-initializers-devise@example.com"
  # config.mailer_sender = "support@myapp.com"

  # If using rails-api, you may want to tell devise to not use ActionDispatch::Flash
  # middleware b/c rails-api does not include it.
  # See: http://stackoverflow.com/q/19600905/806956
  # config.navigational_formats = [:json]

  config.secret_key = '46cb842c4fa4ff71240a8f49ef8a8a58f2884c52c29c4ab7ceea3a6d418fd310ee957d9ec2551f00aa2f41849a7bf0f0c36b835e4b81e1
4a48ee38a79e2fd16c'
end
