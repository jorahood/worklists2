Feature: Boilers

Scenario: Boiler names with .s in them are routable
Given a boiler named "emacs.faq"
Then I can view boiler "emacs.faq"