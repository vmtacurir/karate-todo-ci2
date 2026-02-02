Feature: TC-API-010 - Integración UI + API
  Como usuario de la aplicación
  Quiero crear una tarea desde la interfaz web
  Para verificar que se sincroniza correctamente con la API REST

  Background:
    * configure driver = { type: 'chrome', headless: true }
    * def urlBase = karate.properties['url.base'] || 'http://localhost:8080'
    * driver urlBase

  Scenario: Crear tarea en UI y validar en API
    # Paso 1: Crear tarea desde la interfaz web
    * waitFor('input[name=title]')
    * input('input[name=title]', 'Tarea creada desde UI para validar API')
    * click('button[type=submit]')
    * print 'Paso 1: Tarea creada desde UI'

    # Paso 2: Esperar a que aparezca en la lista de UI
    * waitFor('.todo-item')
    * print 'Paso 2: Tarea visible en UI'

    # Paso 3: Obtener todas las tareas vía API
    * url urlBase + '/api/todos'
    * method get
    * status 200
    * print 'Paso 3: Tareas obtenidas vía API'

    # Paso 4: Verificar que la tarea creada en UI existe en la API
    * match response contains deep { title: 'Tarea creada desde UI para validar API', completed: false }
    * print 'Paso 4: Sincronización UI → API validada exitosamente'

    # Paso 5: Guardar ID de la tarea
    * def createdTask = response.find(t => t.title == 'Tarea creada desde UI para validar API')
    * def taskId = createdTask.id
    * print 'Paso 5: ID de tarea creada:', taskId

    # Paso 6: Validar campos individuales vía API
    * path taskId
    * method get
    * status 200
    * match response.title == 'Tarea creada desde UI para validar API'
    * match response.completed == false
    * print 'Paso 6: Integración UI + API completamente validada'
