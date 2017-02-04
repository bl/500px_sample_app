class Photo
  class << self
    def initialize
    end

    def client
      @client ||= FiveHundredClient.new('photo')
    end

    def pluralized_client
      @client ||= FiveHundredClient.new('photos')
    end

    def popular
      photos = pluralized_client.index(feature: :popular)
    end
  end
end
