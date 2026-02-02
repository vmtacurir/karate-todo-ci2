Feature: TC-API-005 - Eliminación de Tarea y Confirmación
  Como usuario de la API
  Quiero eliminar una tarea existente
  Para verificar que se elimina correctamente del sistema

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase + '/api/todos'

  Scenario: Eliminar tarea y verificar que ya no existe
    # Paso 1: Crear tarea para luego eliminar
    * print '===== PASO 1: Creando tarea ====='
    Given request { title: 'Tarea temporal a eliminar', complete: false }
    When method post
    Then status 201
    * def taskId = response.id
    * print 'Tarea creada con ID:', taskId
    * print ' Espera 10 segundos para ver la tarea en el navegador'
    * java.lang.Thread.sleep(10000)
    * print ' Ve a http://localhost:8080 y verás la tarea creada'

    # Paso 2: Verificar que la tarea existe antes de eliminar
    * print '\n===== PASO 2: Verificando que la tarea existe ====='
    Given path taskId
    When method get
    Then status 200
    And match response.id == taskId
    * print '✅ Tarea confirmada en el servidor'
    * java.lang.Thread.sleep(1000)

    # Paso 3: Eliminar la tarea
    * print '\n===== PASO 3: Eliminando la tarea ====='
    Given path taskId
    When method delete
    Then status 200
    * print 'Tarea eliminada exitosamente'
    * java.lang.Thread.sleep(1000)
    * print ' Espera 10 segundos...'
    * java.lang.Thread.sleep(10000)
    * print ' Ve a http://localhost:8080 y recarga (F5) - la tarea debe haber desaparecido'

    # Paso 4: Verificar que la tarea ya no existe (debe retornar 404)
    * print '\n===== PASO 4: Confirmando que la tarea no existe ====='
    Given path taskId
    When method get
    Then status 404
    * print ' Confirmación: tarea no encontrada después de eliminar'
    * print '===== PRUEBA COMPLETADA EXITOSAMENTE ====='
