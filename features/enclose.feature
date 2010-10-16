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
