class Photo < FiveHundred::Orm
  orm_attr :id, :name, :description, :user_id, :to_whom_user_id, :body, :created_at, :parent_id

  # TODO: resolve this to work with pluralized associations
  #has_many :image

  # TODO: automate associations via ActiveRecord-like "has_many"
  def images
    @images ||= @data[:images].map do |image|
      Image.new(image)
    end
  end

  def user
    @user ||= User.new(@data[:user])
  end

  class << self
    def index(options = {})
      options[:feature] ||= :popular
      options[:page] ||= 1

      resources = pluralized_client.index(options)
      resources[class_name.pluralize].map do |resource|
        self.new(resource)
      end
    end
  end
end
