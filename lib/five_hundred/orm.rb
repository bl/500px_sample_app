module FiveHundred
  class Orm
    include ActiveModel::Model

    class << self
      def orm_attr(*attributes)
        return if defined? @_orm_attributes
        @_orm_attributes = attributes

        define_attributes(@_orm_attributes)
      end

      def orm_attributes
        @_orm_attributes
      end

      def has_many(resource)
        orm_has_many_associations << resource.to_s
      end

      def orm_has_many_associations
        @_orm_has_many ||= []
      end

      def find(id)
        resource = client.get(id)
        self.new(resource)
      end

      def client
        @client ||= FiveHundred::Client.new(class_name)
      end

      def pluralized_client
        @pluralized_client ||= FiveHundred::Client.new(class_name.pluralize)
      end

      private

      def class_name
        name.downcase
      end

      def define_attributes(attributes)
        attr_accessor *attributes

        define_method(:attributes) do
          attributes.each_with_object({}) do |attribute, hash|
            hash[attribute] = send(attribute)
          end
        end
      end
    end

    def initialize(attributes = {})
      super(attributes.slice(*self.class.orm_attributes))
      #initialize_associations(attributes)
      # store entire response data into data hash
      @data = attributes
    end

    def persisted?
      id.present?
    end

    private

    # TODO: metaprogram association attr_accessors
    def initialize_associations(attribute)
      self.class.orm_has_many_associations.each do |association|
        next unless association_attributes = attribute[association.pluralize]
        next unless klass = association.capitalize.constantize

        attr_accessor association.pluralize

        klass_objects = association_attributes.map do |ass_attr|
          klass.new(ass_attr)
        end
        send("#{association.pluralize}=", klass_objects)
      end
    end
  end
end
