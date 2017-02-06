class Photo < FiveHundred::Orm
  orm_attr :id, :user_id, :to_whom_user_id, :body, :created_at, :parent_id, :user

  # TODO: resolve this to work with pluralized associations
  #has_many :image

  # TODO: automate associations via ActiveRecord-like "has_many"
  def images
    @images ||= @data[:images].map do |image|
      Image.new(image)
    end
  end

  class << self
    def popular
      resources = pluralized_client.index(feature: :popular)
      resources[class_name.pluralize].map do |resource|
        self.new(resource)
      end
    end
  end
end
