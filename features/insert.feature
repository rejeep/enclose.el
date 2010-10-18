Feature: Insert
  In order to be faster when typing
  As an Emacs user
  I want to insert pairs around cursor

  Background:
    Given enclose mode is active
    
  Scenario: Enclose when no text
    When I press "("
    Then I should see "()"
    And the cursor should be between "(" and ")"

  Scenario: Enclose when at end of text
    When I insert "foo"
    And I go to end of buffer
    And I press "("
    Then I should see "foo()"
    And the cursor should be between "(" and ")"

  Scenario: Do not enclose when at beginning of text
    When I insert "foo"
    And I go to beginning of buffer
    And I press "("
    Then I should see "(foo"

  Scenario: Do not enclose when in the middle of text
    When I insert "foobar"
    And I place the cursor between "foo" and "bar"
    And I press "("
    Then I should see "foo(bar"

  Scenario: Do not enclose when region is selected
    When I insert "foomebar"
    And I select "me"
    And I press "("
    Then I should see "foo(mebar"

  Scenario: Enclose multiple times
    When I press "("
    And I press "("
    Then I should see "(())"
    And the cursor should be between "((" and "))"
