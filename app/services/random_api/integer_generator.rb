module RandomApi
  class IntegerGenerator
    attr_reader :max

    API_URL = 'https://www.random.org/integers/'

    def initialize(max:)
      @max = max
    end

    def generate
      response = RestClient.get "#{API_URL}?#{url_params}"
      response.body.to_i
    end

    def url_params
      @_url_params ||= {
        num: 1, min: 0, max: 2 * max,
        col: 1, base: 10, format: 'plain', rnd: 'new'
      }.to_query
    end
  end
end
