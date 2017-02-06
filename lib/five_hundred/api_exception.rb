module FiveHundred
  class ApiException < KeyError
    # TODO the rest
    attr_reader :error, :status

    def initialize(response)
      @error = response[:error]
      @status = response[:status]
    end
  end
end
