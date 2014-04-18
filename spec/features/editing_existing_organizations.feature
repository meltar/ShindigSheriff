Feature: Editing an existing organization

Scenario: Succesfully editing an existing organization
    Given I am a logged in user
      And I am at the edit organization page
    When I complete the form with the following:

      | ID                        | Input                     |
      | organization_name         | Cylon Meetup              |
      | organization_website      | cylons.notaruse.com       |

      And I click "Update Organization"
    Then I should see "Cylon Meetup"
      And I should see "cylons.notaruse.com"

Scenario: Submitting an incomplete form
    Given I am a logged in user
      And I am at the edit organization page
    When I complete the form with the following:

      | ID                        | Input                     |
      | organization_name         |                           |
      | organization_website      | cylons.notaruse.com       |

      And I click "Update Organization"
    Then I should see "Error(s) while editing organization: Name can't be blank"


