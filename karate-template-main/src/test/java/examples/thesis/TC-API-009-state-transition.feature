Feature: TC-API-009 - Transición Completa de Estado de Tarea
  Como usuario de la API
  Quiero realizar el ciclo completo de vida de una tarea
  Para validar las transiciones de estado desde pendiente hasta completada

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase + '/api/todos'

  Scenario: Ciclo completo - Crear pendiente → Actualizar a completada → Verificar
    # Paso 1: Crear tarea en estado pendiente
    Given request { title: 'Completar casos de prueba de tesis', completed: false }
    When method post
    Then status 201
    And match response.completed == false
    * def taskId = response.id
    * print 'Paso 1: Tarea creada en estado PENDIENTE, ID:', taskId

    # Paso 2: Verificar estado inicial (pendiente)
    Given path taskId
    When method get
    Then status 200
    And match response.completed == false
    * print 'Paso 2: Estado PENDIENTE confirmado'

    # Paso 3: Transición a estado completada
    Given path taskId
    And request { title: 'Completar casos de prueba de tesis', completed: true }
    When method put
    Then status 200
    And match response.completed == true
    * print 'Paso 3: Transición exitosa a estado COMPLETADA'

    # Paso 4: Verificar persistencia del nuevo estado
    Given path taskId
    When method get
    Then status 200
    And match response.completed == true
    And match response.title == 'Completar casos de prueba de tesis'
    * print 'Paso 4: Estado COMPLETADA persistido correctamente'

    # Paso 5: Revertir a estado pendiente (validar bidireccionalidad)
    Given path taskId
    And request { title: 'Completar casos de prueba de tesis', completed: false }
    When method put
    Then status 200
    And match response.completed == false
    * print 'Paso 5: Transición reversa exitosa - vuelve a PENDIENTE'

    # Paso 6: Verificar estado final
    Given path taskId
    When method get
    Then status 200
    And match response.completed == false
    * print 'Paso 6: Ciclo completo validado - Transiciones bidireccionales funcionan'
