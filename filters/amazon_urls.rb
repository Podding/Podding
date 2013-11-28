# A TextFilter that generates Amazon urls
# Usage: [Product Name]( ASIN(10 characters, uppercase letters or numbers) )
# In config.yaml specify: amazon_id (your affiliate id), amazon_base_url (for example: https://amazon.de)

class AmazonUrls < TextFilter
  needs :markdown

  def render(content)
    asin_pattern = /\(\s*([(\d)(A-Z)]{10})\s*\)/

    # Set defaults
    amazon_base_url = "https://amazon.com"
    amazon_id = nil

    amazon_base_url = Settings["amazon_base_url"] if Settings["amazon_base_url"]
    amazon_id = Settings["amazon_id"] if Settings["amazon_id"]

    content.gsub(asin_pattern) do |match|
      asin = match[1..10]

      amazon_link = "( "
      amazon_link += amazon_base_url
      amazon_link += "/dp/"
      amazon_link += asin
      if amazon_id
        amazon_link += "?tag="
        amazon_link += amazon_id
      end
      amazon_link += " )"

      amazon_link
    end
  end
end

TextFilterEngine.register_filter(AmazonUrls)

