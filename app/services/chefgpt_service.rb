require 'json'
class ChefgptService
  attr_reader :client, :uploaded_ingredients, :pantry_ingredients, :time, :people

  def initialize(combined_ingredients, time, people)
    @client = OpenAI::Client.new(api_key: ENV['OPENAI_ACCESS_TOKEN'])
    @combined_ingredients = combined_ingredients
    @time = time
    @people = people
    @img_search = ImgSearchService.new
  end

  def generate_recipes
    prompt = "Generate 3 recipes that only use the following ingredients: #{@combined_ingredients.join(", ")}. Each recipe should take no more than #{time} minutes and serve #{people} people"
    gpt_response = fetch_completion_from_openai(prompt, 1200)
    begin
      data = JSON.parse(gpt_response)
    rescue JSON::ParserError => e
      puts "Error parsing JSON: #{e.message}"
    end
    raise
    create_recipe_from_json(data["recipes"])
  end

  private

  def fetch_completion_from_openai(prompt, max_tokens)
    messages = [
      { role: "system", content: "you are a helpful cooking assistant who only responds in correct json string syntax. format the string with these fields: {recipes: [{title:, desc:, steps: [], ingredients:[]} include metric units for ingredients. Only respond with code as plain text without code block syntax around it.
      " },
      { role: "user", content: prompt }
    ]

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo-16k-0613",
        messages: messages,
        max_tokens: max_tokens,
        temperature: 0.2
      })

    response.dig("choices", 0, "message", "content")
  rescue => e
    Rails.logger.error "Failed to call the OpenAI API. Error: #{e.message}"
    nil
  end

  def parse_recipes(gpt_response)
  end

  def create_recipe_from_json(recipes_hash)
    recipe_collection = []
    recipes_hash.each do |recipe|
      title = recipe["title"]
      content = recipe["desc"]
      ingredients = recipe["ingredients"]
      best_image = @img_search.search(title)
      json_steps = recipe["steps"].each_with_index { |step, index| "#{index} #{step}" }
      gpt_recipe_instance = Recipe.create(
              title: title,
              image: best_image,
              content: content,
              time: time,
              steps: json_steps,
              ings: ingredients,
              people: people
      )
      recipe_collection << gpt_recipe_instance
    end
    recipe_collection
  end
end
