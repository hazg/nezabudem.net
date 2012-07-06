class ForemFormatter
  extend ActionView::Helpers::TagHelper
 
  class Sanitizer
    extend ActionView::Helpers::SanitizeHelper
    def own_sanitize( text )
      self.sanitize(text, :tags=>%W(p div ul li ol blockquote span strike b i pre h1 h2 h3 h4 table tr td th tbody), :attributes=>[])
    end
  end
  def self.format( text )
    content_tag 'div', text.html_safe
  end
  def self.sanitize( text )
    text
  end
end
