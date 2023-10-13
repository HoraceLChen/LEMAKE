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
    prompt = "Generate 3 recipes that only use the following ingredients: #{@combined_ingredients.join(", ")}. For each recipe, start with 'title: [Recipe Title]' on one line, followed by the description on the next line, then ingredients and finally instructions. Separate each recipe with a line that says '---'. Each recipe should take no more than #{@time} minutes, serve #{@people} people, and include measurements for ingredients in metric units."
    full_text = fetch_completion_from_openai(prompt, 1600)
    parse_recipes(full_text)
  end

  private

  def fetch_completion_from_openai(prompt, max_tokens)
    messages = [
      { role: "system", content: "You are a helpful assistant that generates recipes." },
      { role: "user", content: prompt }
    ]

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo-16k",
        messages: messages,
        max_tokens: max_tokens,
        temperature: 0.2
      })

    response.dig("choices", 0, "message", "content")
  rescue => e
    Rails.logger.error "Failed to call the OpenAI API. Error: #{e.message}"
    nil
  end

  def parse_recipes(full_text)
    return [] unless full_text

    recipe_blocks = full_text.split("---").map(&:strip).reject(&:empty?)
    recipe_instances = []

    recipe_blocks.each do |recipe_block|
      lines = recipe_block.split("\n").map(&:strip)
      title, description, ingredients, steps = parse_recipe_block(lines)

      best_image = @img_search.search(title)

      recipe_instance = Recipe.create(
        title: title,
        image: best_image,
        content: description,
        time: time,
        steps: steps,
        ings: ingredients,
        people: people
      )
      recipe_instances << recipe_instance
    end

    recipe_instances
  end

  def parse_recipe_block(lines)
    title = lines.find { |line| line.start_with?('title:') }&.split(':', 2)&.last&.strip
    description = lines[1]&.strip

    ingredients_start_index = lines.index { |line| line.strip.downcase == 'ingredients' }&.+(1)
    instructions_start_index = lines.index { |line| line.strip.downcase == 'instructions' }&.+(1)

    ingredients = ingredients_start_index && instructions_start_index ? lines[ingredients_start_index...instructions_start_index - 1] : []
    ingredients = ingredients.map { |item| item.sub('- ', '').strip }

    steps = instructions_start_index ? lines[instructions_start_index..-1].join(' ').split(/\d+\./).map(&:strip).reject(&:empty?) : []

    [title, description, ingredients, steps]
  end
end
