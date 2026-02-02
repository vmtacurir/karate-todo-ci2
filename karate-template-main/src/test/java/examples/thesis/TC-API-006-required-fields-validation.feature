Feature: TC-API-006 - Validación de Campos Requeridos
  Como tester de la API
  Quiero validar el comportamiento cuando se omiten campos obligatorios
  Para documentar la ausencia de validación en el sistema

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase + '/api/todos'

  Scenario: Intentar crear tarea sin campo 'title' obligatorio
    # Nota: Este caso documenta que la API ACEPTA tareas sin campo 'title'
    # Esto constituye un defecto (DEF-001) de validación
    
    # Paso 1: Enviar request sin campo 'title'
    Given request { completed: false }
    When method post
    Then status 201
    * def taskId = response.id
    * print 'HALLAZGO: API acepta tarea sin campo title, ID:', taskId

    # Paso 2: Verificar que la tarea se creó sin el campo 'title'
    Given path taskId
    When method get
    Then status 200
    # Documentar el estado actual: campo 'title' puede estar ausente o null
    And match response.id == taskId
    And match response.completed == false
    * print 'DEFECTO DOCUMENTADO: La API no valida campos requeridos'
    * print 'Comportamiento esperado: status 400 con mensaje de error'
    * print 'Comportamiento actual: status 201, tarea creada sin validación'
