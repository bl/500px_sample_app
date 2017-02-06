settings = Settings.fivehundred || { consumer_key: ENV['FIVE_HUNDRED_CONSUMER_KEY'], consumer_secret: ENV['FIVE_HUNDRED_CONSUMER_SECRET'] }
FiveHundred::Authenticator.configure(settings)
