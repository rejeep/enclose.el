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

  Scenario: Do not remove pair when remove pair option is disabled
    Given enclose mode is active
    And remove pair option is disabled
    When I press "("
    Then I should see "()"
    When I press "DEL"
    Then I should see ")"
    And I should not see "()"
    
