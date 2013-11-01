# A TextFilter that shifts the heading levels in Markdown to start at a certain level
# Options:
# :heading_start_level => NUMBER (from 0 to 6) (default: 0)
#   - All heading levels will be shifted to start at this level
#   - 0 means "don't shift"
# :heading_max_level => NUMBER (default: 6)
#   - The highest heading level allowed, default (by HTML) is 6.

class HeadingShifter < TextFilter
  needs :markdown
  defaults heading_start_level: 0, heading_max_level: 6

  def render(content)
    start_level = @settings[:heading_start_level]
    max_level = @settings[:heading_max_level]
    if start_level != 0
      set_start_heading_level(content, start_level, max_level)
    else
      content
    end
  end

  private

    # Helpers

    def heading_regex(h_level = 1)
      eval "regex = /^(\s*)[#]{#{ h_level }}\s(.*)$/"
    end

    def generate_fence(number)
      out = ""
      number.times{ out += "#" }
      out
    end

    def generate_heading(content, level = 1, leading_whitespace = "")
      "#{ leading_whitespace }#{ generate_fence(level) } #{ content }"
    end

    def find_min_heading_level(content, max_level)
      level = 1
      until content =~ heading_regex(level) or level == max_level do
        level += 1
      end
      level
    end

    # Shifters

    # Expects positive shift_amount, would set everything to one level otherwise
    def shift_headings_up(content, shift_amount, min_level, max_level)
      current_level = max_level

      until current_level < min_level do
        new_level = current_level + shift_amount
        if new_level <= max_level and new_level >= 1
          content =  shift_headings_at_level(content, current_level, shift_amount)
        end
        current_level -= 1
      end

      content
    end

    # Expects negative shift_amount
    def shift_headings_down(content, shift_amount, min_level, max_level)
      current_level = 1

      while current_level <= max_level do
        new_level = current_level + shift_amount
        if new_level <= max_level and new_level >= 1
          content =  shift_headings_at_level(content, current_level, shift_amount)
        end
        current_level += 1
      end

      content
    end

    def shift_headings_at_level(content, level, shift_amount)
      content.gsub(heading_regex(level)) do |match|
        generate_heading($2, level + shift_amount, $1)
      end
    end

    # Main shifting

    def set_start_heading_level(content, start_level, max_level)
      min_level = find_min_heading_level(content, max_level)
      shift_amount = start_level - min_level

      if shift_amount <= 0
        shift_headings_down(content, shift_amount, min_level, max_level)
      else
        shift_headings_up(content, shift_amount, min_level, max_level)
      end
    end

end

TextFilterEngine.register_filter(HeadingShifter)

