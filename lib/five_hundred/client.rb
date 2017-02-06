module FiveHundred
  class Client
    API_URL = 'https://api.500px.com/v1'

    def initialize(resource_name)
      @resource_name = resource_name
      @authenticator = Authenticator.new(API_URL)
    end

    def index(params)
      request(params)
    end

    private

    def request(params)
      JSON.parse(http_request(params)).with_indifferent_access
    end

    def http_request(params)
      request_params = { params: common_params.merge(params) }
      response = client.get(request_params)
      response.body
    rescue RestClient::RequestFailed => e
      error = JSON.parse(e.response).with_indifferent_access
      raise ApiException.new(error)
    end

    def resource
      @resource_name
    end

    def resource_url
      [API_URL, resource].join('/')
    end

    def common_params
      { consumer_key: @authenticator.consumer_key }
    end

    def client
      @client ||= RestClient::Resource.new(resource_url)
    end

    def initialize_client(url)
      RestClient::Resource.new(url)
    end
  end
end
