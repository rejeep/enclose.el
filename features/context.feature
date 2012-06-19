Feature: Context
  In order to allow for more customization
  An Enclose user
  Should be able to add encloser contexts

  Background: 
    Given I turn on enclose-mode
  
  Scenario: Default context
    Given I add encloser "</>"
    And I insert "List"
    And I go to end of line
    And I press "<"
    Then I should see "List<>"
    And the cursor should be between "<" and ">"
    
  Scenario: Valid context
    Given I add encloser "</>" with context "enclose-before-word-context"
    And I insert "List"
    And I go to beginning of line
    And I press "<"
    Then I should see "<>List"
    And the cursor should be between "<" and ">"

  Scenario: Invalid context
    Given I add encloser "</>" with context "enclose-end-of-line-context"
    And I insert "List"
    And I go to end of line
    And I press "<"
    Then I should not see "List<>"
    But I should see "List<"
    And the cursor should be after "<"
