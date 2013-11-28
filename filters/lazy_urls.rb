# A TextFilter for lazy urls in Markdown
#
# Usage:

# - Link Text http://url.com/fooo
#   + Another Link in the List http://foo.org
#   + Yet another link https://blah.com
#     * One level deeper! http://foo.com/blah

class LazyUrls < TextFilter
  needs :text

  def render(content)
    lazyurl = /^ (\s*) ([-+\*]) (\s*) (.*) (\s) (https?:\/(\/\S+)+) $/x

    return content.gsub(lazyurl) do |match|
      "#{ $1 }#{ $2 } [#{ $4 }]( #{ $6 } )"
    end
  end

end

TextFilterEngine.register_filter(LazyUrls)

