class FiveHundredAuthenticator
  class << self
    attr_reader :consumer_key, :consumer_secret
    def configure(options = {})
      @consumer_key = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
    end
  end
  attr_reader :consumer_key

  def initialize(api_url)
    @api_url = api_url
    @consumer_key = self.class.consumer_key
    @consumer_secret = self.class.consumer_secret
  end

  def request_token
    return @request_token if defined? @request_token
    consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret, {
      site: @api_url,
      request_token_path: '/oauth/request_token',
      access_token_path: '/oauth/access_token',
      authorize_path: '/oauth/authorize'
    })

    @request_token = consumer.get_request_token
  end
end
