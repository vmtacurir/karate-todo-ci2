Feature: TC-API-011 - Creación Múltiple de Tareas (Data-Driven)
  Como usuario de la API
  Quiero crear múltiples tareas con diferentes datos
  Para validar que el sistema maneja correctamente diversos escenarios

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase + '/api/todos'
    # Limpiar datos antes de empezar
    * url urlBase + '/api/reset'
    * method post
    * status 200
    * url urlBase + '/api/todos'

  Scenario Outline: Crear tarea con diferentes combinaciones de datos
    # Paso 1: Crear tarea con datos parametrizados
    * print 'Creando tarea:', '<taskTitle>'
    Given request { title: '<taskTitle>', complete: <isCompleted> }
    When method post
    Then status 201
    And match response.title == '<taskTitle>'
    And match response.complete == <isCompleted>
    * def taskId = response.id
    * print '✅ Tarea creada:', '<taskTitle>', '- ID:', taskId

    # Paso 2: Verificar persistencia
    Given path taskId
    When method get
    Then status 200
    And match response.title == '<taskTitle>'
    And match response.complete == <isCompleted>
    * print '✅ Validación exitosa para:', '<taskTitle>'

    Examples:
      | taskTitle                                      | isCompleted |
      | Disenar casos de prueba para API REST         | false  |
      | Ejecutar pruebas con Karate framework         | false  |
      | Documentar resultados en monografia           | false  |
      | Revisar literatura sobre testing de APIs      | true   |
      | Configurar ambiente de pruebas con Maven      | true   |

  Scenario: Verificar que todas las tareas fueron creadas
    # Obtener listado completo después de crear todas las tareas del outline
    * print '===== Verificando listado completo ====='
    When method get
    Then status 200
    And match response == '#[5]'
    * print '✅ Total de tareas creadas:', response.length
    
    # Verificar que contiene las tareas esperadas
    * print '===== Verificando contenido ====='
    And match response contains deep { title: 'Disenar casos de prueba para API REST', complete: false }
    * print '✅ Tarea 1 encontrada'
    
    And match response contains deep { title: 'Ejecutar pruebas con Karate framework', complete: false }
    * print '✅ Tarea 2 encontrada'
    
    And match response contains deep { title: 'Documentar resultados en monografia', complete: false }
    * print '✅ Tarea 3 encontrada'
    
    And match response contains deep { title: 'Revisar literatura sobre testing de APIs', complete: true }
    * print '✅ Tarea 4 encontrada'
    
    And match response contains deep { title: 'Configurar ambiente de pruebas con Maven', complete: true }
    * print '✅ Tarea 5 encontrada'
    
    * print '===== PRUEBA DATA-DRIVEN COMPLETADA EXITOSAMENTE ====='
