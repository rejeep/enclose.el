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

  Scenario: Global mode
    When I enable the global mode
    And I open temp file "global"
    And I press "("
    Then I should see "()"
    And the cursor should be between "(" and ")"

  Scenario: Preserve focus when switching buffers
    Given I am in buffer "one"
    And I turn on enclose-mode
    When I press "("
    Then I should see "()"
    And the cursor should be between "(" and ")"
    When I switch to buffer "two"
    And I turn on enclose-mode
    And I press "("
    Then I should see "()"
    And the cursor should be between "(" and ")"
    When I press "DEL"
    Then I should not see anything
    When I switch to buffer "one"
    And I press "DEL"
    Then I should not see anything
