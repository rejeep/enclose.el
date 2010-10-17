Feature: Remove
  In order to be faster when typing
  As an Emacs user
  I want to remove matching pairs around point
          
  Background:
    Given I am in buffer "*enclose*"
    And the buffer is empty
    And enclose mode is active
    And transient mark mode is active
    And there is no region selected
  
  Scenario: Remove pair
    When I press "("
    Then I should see "()"
    When I place the cursor between "(" and ")"
    And I press "DEL"
    Then I should not see anything

  Scenario: Remove multiple pairs
    When I press "("
    And I press "("
    Then I should see "(())"
    And the cursor should be between "((" and "))"
    When I press "DEL"
    Then I should see "()"
    And I should not see "(())"
    When I press "DEL"
    Then I should not see anything

  Scenario: Do not remove when no match
    When I insert "(]"
    And I place the cursor between "(" and "]"
    And I press "DEL"
    Then I should see "]"
    And I should not see "(]"

  Scenario: Do not remove pair when remove pair option is disabled
    Given remove pair option is disabled
    When I press "("
    Then I should see "()"
    When I press "DEL"
    Then I should see ")"
    And I should not see "()"

  Scenario: Do not remove pair when cursor is within text
    When I insert "foo()bar"
    And I place the cursor between "(" and ")"
    And I press "DEL"
    Then I should see "foo)bar"
