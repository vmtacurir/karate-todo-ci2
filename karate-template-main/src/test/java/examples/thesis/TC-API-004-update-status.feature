Feature: TC-API-004 - Actualización de Estado de Tarea
  Como usuario de la API
  Quiero actualizar el estado de completitud de una tarea
  Para marcar tareas como completadas o pendientes

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase + '/api/todos'

  Scenario: Actualizar estado completed de false a true
    # Paso 1: Crear tarea con estado pendiente (complete: false)
    Given request { title: 'Escribir informe de resultados', complete: false }
    When method post
    Then status 201
    And match response.complete == false
    * def taskId = response.id
    * print 'Tarea creada con estado pendiente, ID:', taskId

    # Paso 2: Actualizar estado a completada (complete: true)
    Given path taskId
    And request { title: 'Escribir informe de resultados', complete: true }
    When method put
    Then status 201
    And match response.id == taskId
    And match response.title == 'Escribir informe de resultados'
    And match response.complete == true
    * print 'Estado actualizado a completada'

    # Paso 3: Verificar persistencia de la actualización
    Given path taskId
    When method get
    Then status 200
    And match response.complete == true
    * print 'Actualización verificada exitosamente'
