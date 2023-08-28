class SpoonacularServiceRecipe

  def initialize(api_key, spoonacular_id)
    @api_key = api_key
    @spoonacular_id = spoonacular_id
    @url = "https://api.spoonacular.com/recipes/#{@spoonacular_id}/information"
    @connection = Faraday.new(url: @url)
  end

  def search_by_recipe(recipe)
    response = @connection.get do |req|
      req.url @url
      req.params['apiKey'] = @api_key
      req.params['id'] = @spoonacular_id
    end
    results = JSON.parse(response.body) if response.status == 200
  end
end
