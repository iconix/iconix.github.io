require 'active_support/all'

module Jekyll
  module ParameterizeFilter
    def parameterize(raw)
      ActiveSupport::Inflector.parameterize(raw.to_s)
    end
  end

  module Drops
    class UrlDrop < Drop
      alias_method :old_categories, :categories

      # Parameterize categories in urls
      def categories
        Utils.slugify(old_categories)
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::ParameterizeFilter)
