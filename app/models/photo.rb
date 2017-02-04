class Photo
  include ActiveModel::Model
  attr_accessor :id, :user_id, :to_whom_user_id, :body, :created_at, :parent_id, :user, :data

  def initialize(attributes = {})
    super(attributes.slice(*self.attributes.keys))
    # store entire response data into data hash
    @data = attributes
  end

  def attributes
    {
      id: id,
      user_id: user_id,
      to_whom_user_id: to_whom_user_id,
      body: body,
      created_at: created_at,
      parent_id: parent_id,
      user: user
    }
  end

  class << self
    def find(id)
      resource = client.get(id)
      self.new(resource)
    end

    def client
      @client ||= FiveHundredClient.new(class_name)
    end

    def pluralized_client
      @client ||= FiveHundredClient.new(class_name.pluralize)
    end

    def popular
      resources = pluralized_client.index(feature: :popular)
      resources[class_name.pluralize].map do |resource|
        self.new(resource)
      end
    end

    private

    def class_name
      name.downcase
    end
  end
end
