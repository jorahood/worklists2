Feature: Boiler

Scenario: It is routable with a dot in its name
Given a boiler named "emacs.faq"
When I view the boiler "emacs.faq"
Then I should see "emacs.faq"