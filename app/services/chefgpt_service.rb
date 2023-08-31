
class ChefgptService
  attr_reader :client, :uploaded_ingredients, :pantry_ingredients, :time, :people

  def initialize(uploaded_ingredients, pantry_ingredients, time, people)
    @client = OpenAI::Client.new(api_key: ENV['OPENAI_ACCESS_TOKEN'])
    @uploaded_ingredients = uploaded_ingredients
    @pantry_ingredients = pantry_ingredients
    @time = time
    @people = people
  end

  def generate_recipes
    combined_ingredients = uploaded_ingredients + pantry_ingredients
    # prompt = "Generate 6 recipes that primarily use the following ingredients: #{combined_ingredients.join(", ")}. Each recipe should be formatted as a Ruby hash, like so: { title: 'Recipe Title', description: 'Recipe Description', ingredients: ['Ingredient 1', 'Ingredient 2'], instructions: ['Step 1', 'Step 2'] }. Each recipe should take no more than #{@time} minutes, serve #{@people} people, and include measurements for ingredients in metric units."
    prompt = "Generate 3 recipes that primarily use the following ingredients: #{combined_ingredients.join(", ")}. For each recipe, start with 'title: [Recipe Title]' on one line, followed by the description on the next line, then ingredients and finally instructions. Separate each recipe with a line that says '---'. Each recipe should take no more than #{@time} minutes, serve #{@people} people, and include measurements for ingredients in metric units."
    full_text = fetch_completion_from_openai(prompt, 1600)  # Increased max tokens to allow for more content
    recipes = parse_recipes(full_text)
    recipes
  end

  private

  def fetch_completion_from_openai(prompt, max_tokens)
    messages = [
      { role: "system", content: "You are a helpful assistant that generates recipes."},
      { role: "user", content: prompt }
    ]

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo-16k",
        messages: messages,
        max_tokens: max_tokens,
        temperature: 0.2
      })

    completion = response.dig("choices", 0, "message", "content")
    completion
  rescue => e
    Rails.logger.error "Failed to call the OpenAI API. Error: #{e.message}"
    nil
  end

  def parse_recipes(full_text)
    recipe_blocks = full_text.split("---").map(&:strip).reject(&:empty?)
    recipe_instances = []
    img_search = ImgSearchService.new


    recipe_blocks.each do |recipe_block|
      lines = recipe_block.split("\n").map(&:strip)

      title_line_index = lines.index { |line| line.start_with?("Title:") }
      title = lines[title_line_index].split(":")[1..-1].join(":").strip if title_line_index

      description_line_index = lines.index { |line| line.start_with?("Description:") }
      description = lines[description_line_index].split(":")[1..-1].join(":").strip if description_line_index

      ingredients_start = lines.index("Ingredients:")&.+(1)
      instructions_start = lines.index("Instructions:")&.+(1)

      ingredients = ingredients_start && instructions_start ? lines[ingredients_start..instructions_start-2] : nil

      accumulated_step = ""
      steps = []

      if instructions_start
        lines[instructions_start..-1].each do |line|
          if line.match(/^\d+\./)
            steps << accumulated_step.strip unless accumulated_step.empty?
            accumulated_step = line.sub(/^\d+\.\s*/, '')
          else
            accumulated_step += ' ' + line.strip
          end
        end
      end

      steps << accumulated_step.strip unless accumulated_step.empty?

      best_image = img_search.search(title)

      recipe_instance = Recipe.create(
        title: title,
        image: best_image,
        content: description,
        cuisine: nil,
        time: time,
        steps: steps,
        ings: ingredients,
        people: people
      )
      recipe_instances << recipe_instance
    end

    recipe_instances
  end



end
