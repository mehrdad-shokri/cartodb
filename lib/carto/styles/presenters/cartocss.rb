# encoding: utf-8

module Carto
  module Styles
    module Presenters
      class CartoCSS
        def initialize(class_name: 'layer', cartocss_array: [])
          @class_name = class_name
          @cartocss_array = cartocss_array
        end

        def to_s
          "##{@class_name} {\n"\
          "#{formatted_cartocss_body}\n"\
          "}"
        end

        private

        def formatted_cartocss_body
          formatted_cartocss_properties = @cartocss_array.map do |cartocss_property|
            format_cartocss_property(cartocss_property)
          end

          formatted_cartocss_properties.join("\n")
        end

        def format_cartocss_property(cartocss_property)
          case cartocss_property.class.to_s
            when 'String'
              "  #{cartocss_property}"
            when 'Hash'
              formatted_cartocss_property = cartocss_property.keys.map do |key|
                "  #{key} {\n"\
                "#{cartocss_property[key].map {|v| "    #{v}"}.join("\n")}\n"\
                "  }"
              end

              formatted_cartocss_property.join("\n")
          end
        end
      end
    end
  end
end
