class ImgSearchService
  def initialize
    @url = 'https://customsearch.googleapis.com'
    @conn = Faraday.new(url: @url)
  end

  def search(recipe_name)
    res = @conn.get do |req|
      req.url '/customsearch/v1'
      req.params['key'] = ENV['GOOGLE_API_KEY']
      req.params['cx'] = ENV['GOOGLE_CX_KEY']
      req.params['q'] = recipe_name
      req.params['searchType'] = 'image'
      req.params['num'] = 5
    end
    handle(res)
  end

  private

  def handle(res)
    best_image = nil
    if res.status == 200
      data = JSON.parse(res.body)
      # Initialize to a very large value
      closest_aspect_ratio_diff = Float::INFINITY

      if data['items']
        data['items'][0..4].each do |item|
          if item['image']
            width = item['image']['width'].to_f
            height = item['image']['height'].to_f

            next unless width > 0 && height > 0

            aspect_ratio = width / height
            aspect_ratio_diff = (aspect_ratio - 1.5).abs  # Calculate the absolute difference from the desired aspect ratio

            if aspect_ratio_diff < closest_aspect_ratio_diff
              closest_aspect_ratio_diff = aspect_ratio_diff
              best_image = item['link']
            end
          end
        end
      end
    else
      best_image = "https://www.bolnews.com/wp-content/uploads/2024/01/pappap.jpg"
    end
    best_image  # Return the best image URL or nil if not found
  end
end
