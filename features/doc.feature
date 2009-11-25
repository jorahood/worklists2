Feature: Documents

  Scenario: Requesting doc.xml should give you just the xml
  Given a doc with id ddud
  When I view doc ddud as xml
  Then I should see "ddud" within "kbml"