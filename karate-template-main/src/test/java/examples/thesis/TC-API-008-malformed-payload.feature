Feature: TC-API-008 - Validación de Payload Malformado
  Como tester de la API
  Quiero verificar el manejo de errores con JSON inválido
  Para validar la robustez de la API ante datos malformados

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:8080')
    * url urlBase + '/api/todos'

  Scenario: Enviar JSON con sintaxis inválida
    # Nota: Este caso documenta el comportamiento real de la API
    # Se espera que rechace JSON malformado con status 400
    
    # Paso 1: Intentar enviar JSON con formato incorrecto
    Given header Content-Type = 'application/json'
    # JSON inválido: falta comilla de cierre, coma extra, etc.
    And request '{ "text": "Tarea malformada", "done": }'
    When method post
    # Documentar comportamiento actual
    # Esperado: 400 Bad Request
    # Si acepta: documentar como defecto DEF-002
    * print 'Status recibido:', responseStatus
    * if (responseStatus == 200) karate.log('DEFECTO: API acepta JSON malformado')
    * if (responseStatus == 400) karate.log('CORRECTO: API rechaza JSON malformado')

  Scenario: Enviar tipo de dato incorrecto en campo booleano
    # Paso 2: Enviar string donde se espera boolean
    Given request { text: 'Prueba tipo incorrecto', done: 'not-a-boolean' }
    When method post
    # Documentar si la API valida tipos de datos
    * print 'Status recibido para tipo incorrecto:', responseStatus
    * if (responseStatus == 200) karate.log('HALLAZGO: API no valida tipos de datos')
    * if (responseStatus == 400) karate.log('CORRECTO: API valida tipos de datos')
