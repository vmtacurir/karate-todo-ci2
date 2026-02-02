Feature: TC-API-002 - Consulta de Tarea por ID
  Como usuario de la API
  Quiero consultar una tarea existente por su ID
  Para obtener sus detalles completos

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase + '/api/todos'

  Scenario: Consultar tarea existente por ID válido
    # Paso 1: Crear tarea primero para tener un ID válido
    Given request { title: 'Revisar documentacion de Karate', complete: false }
    When method post
    Then status 201
    * def taskId = response.id
    * print 'Tarea creada con ID:', taskId

    # Paso 2: Consultar la tarea por ID
    Given path taskId
    When method get
    Then status 200
    And match response.id == taskId
    And match response.title == 'Revisar documentacion de Karate'
    And match response.complete == false
    And match response == { id: '#string', title: '#string', complete: '#boolean' }
    * print 'Consulta exitosa para ID:', taskId
