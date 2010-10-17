Feature: Enclose
  In order to be faster when typing
  As an Emacs user
  I want to be enclosing

  Scenario: Add encloser
    Given enclose mode is active
    And I add encloser "</>"
    When I press "<"
    Then I should see "<>"
    And the cursor should be between "<" and ">"
  
  Scenario: Remove encloser
    Given enclose mode is active
    And I remove encloser "("
    When I press "("
    Then I should see "("
    And I should not see "()"
    
