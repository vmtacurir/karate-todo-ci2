Feature: karate basic Todos
Background: 
    * url 'http://localhost:8080/api/todos'
Scenario: get all todos
        Given url 'http://localhost:8080/api/todos'
        When method get
        Then status 200
Scenario: Basic todo flow
#Create a single todo
        Given request { "title": "new todo from karate", "completed": false }
        When method post
        Then status 201