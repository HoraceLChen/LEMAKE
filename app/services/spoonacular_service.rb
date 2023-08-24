class SpoonacularService
  BASE_URL = 'https://api.spoonacular.com/recipes/findByIngredients'

  def initialize(api_key)
    @api_key = api_key
    @connection = Faraday.new(url: BASE_URL)
  end

  def search_by_ingredients(ingredients)
    response = @connection.get do |req|
      req.url BASE_URL
      req.params['apiKey'] = @api_key
      req.params['ingredients'] = ingredients.join(',')
    end

    JSON.parse(response.body) if response.status == 200
  end
end
