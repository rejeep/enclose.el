Feature: Enclose
  In order to be faster when typing
  As an Emacs user
  I want to enclose cursor within punctuations automatically
  
  Background:
    Given I am in buffer "*enclose*"
    And the buffer is empty
    
  # TODO: Should really be a Scenario Outline
  Scenario: Enclose
    Given enclose mode is active
    When I press "("
    Then I should see "()"
    And the cursor should be between "(" and ")"
  
  Scenario: Remove pair
    Given enclose mode is active
    When I insert "()"
    And I place the cursor between "(" and ")"
    When I press "DEL"
    Then I should not see "("
    And I should not see ")"
    
  Scenario: Remove multiple pairs
    Given enclose mode is active
    When I insert "(())"
    And I place the cursor between "((" and "))"
    When I press "DEL"
    Then I should see "()"
    And I should not see "(())"
    When I press "DEL"
    Then I should not see "()"
    
  Scenario: Fallback when no match
    Given enclose mode is active
    When I insert "(]"
    And I place the cursor between "(" and "]"
    When I press "DEL"
    Then I should see "]"
    And I should not see "(]"
    
