Feature: Enclose
  In order to be faster when typing
  As an Emacs user
  I want to be enclosing

  Scenario: Add encloser
    Given I turn on enclose-mode
    And I add encloser "</>"
    When I press "<"
    Then I should see "<>"
    And the cursor should be between "<" and ">"

  Scenario: Remove encloser
    Given I turn on enclose-mode
    And I remove encloser "("
    When I press "("
    Then I should see "("
    But I should not see "()"

  Scenario: Remove right encloser key
    Given I turn on enclose-mode
    And I add encloser "</>"
    And I remove encloser "<"
    Then the key ">" should not be bound by enclose

  Scenario: Global mode
    Given I turn on enclose globaly
    When I open temp file "global"
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

  Scenario: Except modes
    Given I add "text-mode" as an except mode
    And I turn on enclose globaly
    When I open temp file "global"
    And I turn on text-mode
    And I press "("
    Then I should not see "()"
    But I should see "("

  Scenario: Do not override enclosers when starting enclose-mode
    Given I add encloser "(/)" with context "enclose-before-word-context"
    And I turn on enclose-mode
    And I insert "List"
    And I go to beginning of line
    And I press "("
    Then I should see "()List"

  Scenario: Press right encloser
    Given I add encloser "(/)"
    And I turn on enclose-mode
    And I press ")"
    Then I should not see "))"
    But I should see ")"
