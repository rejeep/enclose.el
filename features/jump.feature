Feature: Jump
  In order to be faster when typing
  As an Emacs user
  I want to jump over right encloser

  Background: 
    Given I turn on enclose-mode

  Scenario: Jump when not moved
    When I press "("
    Then I should see "()"
    When I press ")"
    Then I should not see "())"
    But I should see "()"
    And the cursor should be after "()"

  Scenario: Do not jump when moved
    When I press "("
    Then I should see "()"
    When I press "C-f"
    And I press "C-b"
    And I press ")"
    Then I should see "())"
    And the cursor should be between "()" and ")"

  Scenario: Do not jump on other encloser
    When I press "("
    Then I should see "()"
    And I press "'"
    Then I should not see "()"
    But I should see "('')"
    And the cursor should be between "('" and "')"

  Scenario: Same left and right should jump
    Given I add encloser "'/'"
    And I turn on enclose-mode
    And I press "'"
    And I press "'"
    Then I should not see "''''"
    But I should see "''"
