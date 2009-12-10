Feature: Boiler

Scenario: It is routable with a dot in its name
Given a boiler named "emacs.faq"
Then I view the boiler "emacs.faq"