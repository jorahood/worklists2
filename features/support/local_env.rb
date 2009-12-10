# support stubs:
require "spec/mocks"

# support factory_girl
require 'factory_girl'
require 'spec/factories'
# pretty formatting
require File.expand_path(File.dirname(__FILE__) + '/textmate_formatter')

# patch Webrat to allow Xpath selectors for "within" scoping

# https://webrat.lighthouseapp.com/projects/10503/tickets/153-within-should-support-xpath
# Webrat does not accept xpath selectors. This is a quick hack to make
# it work for me. It tries to call css_at with the selector, if it
# raises a syntax error the selector is passed to xpath_at. If that
# fails then the original exception is raised.

module Webrat
  class Scope
    protected

    def xpath_scoped_dom
      Webrat::XML.xpath_at(@scope.dom, @selector)
    end

    def scoped_dom
      begin
        Webrat::XML.css_at(@scope.dom, @selector)
      rescue Nokogiri::CSS::SyntaxError, Nokogiri::XML::XPath::SyntaxError => e
        begin
          # That was not a css selector, mayby it's an xpath selector?
          xpath_scoped_dom
        rescue
          # Raise original css syntax error if selector is not xpath either
          raise e
        end
      end
    end
  end
end
