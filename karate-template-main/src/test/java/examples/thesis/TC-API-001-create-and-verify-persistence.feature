Feature: TC-API-001 - Creación de Tarea y Verificación de Persistencia
  Como usuario de la API
  Quiero crear una nueva tarea
  Para verificar que se almacena correctamente y puede ser recuperada

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase + '/api/todos'

  Scenario: Crear tarea con datos válidos y verificar persistencia mediante consulta GET
    # Paso 1: Crear tarea con POST
    Given request { title: 'Implementar pruebas automatizadas', complete: false }
    When method post
    Then status 201
    And match response.id == '#string'
    And match response.title == 'Implementar pruebas automatizadas'
    And match response.complete == false
    * def taskId = response.id
    * print 'Tarea creada con ID:', taskId

    # Paso 2: Verificar persistencia consultando por ID
    Given path taskId
    When method get
    Then status 200
    And match response == { id: '#(taskId)', title: 'Implementar pruebas automatizadas', complete: false }
    * print 'Persistencia verificada exitosamente'
