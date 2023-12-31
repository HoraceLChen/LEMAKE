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
      steps_content = []
      result["analyzedInstructions"][0]["steps"].map do |step|
        steps_content.push(step["step"])
      end
      Recipe.create(
      title: result["title"],
      image: result["image"],
      content: result["summary"].gsub(/<[^>]+>.*?/, ''),
      cuisine: result["cuisines"][0],
      time: result["readyInMinutes"],
      steps: steps_content,
      people: result["servings"],
      spoonacular_id: result["id"]
      )
    end
  end

  def search_by_recipe(recipe)
  @connection_r = Faraday.new(url: "https://api.spoonacular.com/recipes/#{recipe}/information?")
    response = @connection_r.get do |req|
      req.url @connection_r
      req.params['apiKey'] = @api_key
    end
    results = JSON.parse(response.body) if response.status == 200
  end
end
