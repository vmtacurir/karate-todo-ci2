Feature: TC-API-007 - Error 404 para ID Inexistente
  Como usuario de la API
  Quiero verificar el manejo de errores al consultar un ID inexistente
  Para validar que la API retorna el código HTTP 404 apropiadamente

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase + '/api/todos'

  Scenario: Consultar tarea con ID que no existe en el sistema
    # Paso 1: Usar un ID que no existe (UUID aleatorio o ID muy alto)
    * def nonExistentId = '99999999'
    * print 'Intentando consultar ID inexistente:', nonExistentId

    # Paso 2: Intentar obtener tarea con ID inexistente
    Given path nonExistentId
    When method get
    Then status 404
    * print 'Validación exitosa: API retorna 404 para ID inexistente'

  Scenario: Eliminar tarea con ID inexistente
    # Validar que DELETE también retorna 404 para ID inexistente
    * def nonExistentId = '88888888'
    * print 'Intentando eliminar ID inexistente:', nonExistentId

    Given path nonExistentId
    When method delete
    Then status 404
    * print 'Validación exitosa: DELETE retorna 404 para ID inexistente'
