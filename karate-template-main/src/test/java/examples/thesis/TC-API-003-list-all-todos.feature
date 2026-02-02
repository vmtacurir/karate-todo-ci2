Feature: TC-API-003 - Listado de Todas las Tareas
  Como usuario de la API
  Quiero obtener un listado completo de todas las tareas
  Para visualizar el inventario actual de pendientes

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase + '/api/todos'

  Scenario: Listar todas las tareas y verificar estructura de respuesta
    # Paso 1: Limpiar datos previos
    * print '===== PASO 1: Limpiando datos previos ====='
    Given url urlBase + '/api/reset'
    When method post
    Then status 200
    * print '✅ Base de datos limpiada'

    # Paso 2: Crear múltiples tareas para probar el listado
    * print '===== PASO 2: Creando 3 tareas de prueba ====='
    Given url urlBase + '/api/todos'
    And request { title: 'Disenar base de datos', complete: false }
    When method post
    Then status 201
    * def id1 = response.id
    * print 'Tarea 1 creada:', id1

    Given request { title: 'Desarrollar API REST', complete: true }
    When method post
    Then status 201
    * def id2 = response.id
    * print 'Tarea 2 creada:', id2

    Given request { title: 'Realizar pruebas automatizadas', complete: false }
    When method post
    Then status 201
    * def id3 = response.id
    * print 'Tarea 3 creada:', id3

    # Paso 3: Obtener listado completo
    * print '===== PASO 3: Obteniendo listado completo ====='
    When method get
    Then status 200
    * print ' Respuesta recibida del servidor'
    
    # Verificar cantidad
    * assert response.length == 3
    * print ' Se encontraron exactamente 3 tareas'

    # Verificar estructura
    And match each response == { id: '#string', title: '#string', complete: '#boolean' }
    * print ' Estructura de datos verificada'

    # Verificar contenido específico
    * print '\n===== PASO 4: Verificando contenido de cada tarea ====='
    And match response contains [{ id: '#(id1)', title: 'Disenar base de datos', complete: false }]
    * print ' Tarea 1 verificada'
    
    And match response contains [{ id: '#(id2)', title: 'Desarrollar API REST', complete: true }]
    * print ' Tarea 2 verificada'
    
    And match response contains [{ id: '#(id3)', title: 'Realizar pruebas automatizadas', complete: false }]
    * print ' Tarea 3 verificada'

    * print '===== PRUEBA COMPLETADA EXITOSAMENTE ====='
    * print 'Listado completo verificado:', response.length, 'tareas encontradas'
