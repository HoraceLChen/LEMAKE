class SpoonacularService
  BASE_URL = 'https://api.spoonacular.com/recipes/complexSearch'

  def initialize(api_key)
    @api_key = api_key
    @connection = Faraday.new(url: BASE_URL)
    @recipes = []
  end

  def search_by_ingredients(ingredients)
    response = @connection.get do |req|
      req.url BASE_URL
      req.params['apiKey'] = @api_key
      req.params['includeIngredients'] = ingredients.join(',')
      # req.params['type'] = "main course"
      req.params['instructionsRequired'] = true
      req.params['fillIngredients'] = false
      req.params['addRecipeInformation'] = true
      req.params['number'] = 6
    end
    results = JSON.parse(response.body) if response.status == 200
    results["results"].map do |result|
      Recipe.create(
      title: result["title"],
      image: result["image"],
      content: result["summary"].gsub(/<[^>]+>.*?/, ''),
      cuisine: result["image"],
      time: result["readyInMinutes"],
      people: result["servings"]
      )
    end
  end
end
