# Chat Engine - Documentación para Claude

## Comandos de Desarrollo

### Testing
```bash
bundle exec rspec                    # Ejecutar todas las pruebas
bundle exec rspec spec/models        # Ejecutar solo pruebas de modelos
bundle exec rspec spec/requests      # Ejecutar solo pruebas de requests
```

### Calidad de Código
```bash
bundle exec rubocop                  # Verificar estilo de código
bundle exec rubocop -a               # Auto-corregir problemas de estilo
bundle exec brakeman                 # Análisis de seguridad
bundle exec bundle-audit             # Verificar vulnerabilidades en gemas
```

### Base de Datos
```bash
bin/rails db:create                  # Crear base de datos
bin/rails db:migrate                 # Ejecutar migraciones
bin/rails db:schema:load             # Cargar esquema
bin/rails db:reset                   # Resetear base de datos
```

### Servidor y Consola
```bash
rails server                         # Iniciar servidor (http://localhost:3000)
rails console                        # Abrir consola Rails con FactoryBot
```

## Arquitectura

### Estructura de Directorios

```
app/
├── controllers/chat_engine/v1/      # Controladores API v1
├── models/chat_engine/              # Modelos de dominio
├── services/chat_engine/            # Objetos de servicio
├── listeners/chat_engine/           # Listeners de eventos Wisper
├── overrides/                       # Extensiones a modelos de otros engines
└── views/chat_engine/v1/            # Vistas Jbuilder para API

lib/chat_engine/
├── config/initializers/             # Inicializadores del engine
└── test_helpers/                    # Helpers para testing

spec/
├── factories/                       # Factories de FactoryBot
├── models/                          # Specs de modelos
├── requests/                        # Specs de API
└── services/                        # Specs de servicios
```

### Dependencias

- **users_engine**: Requerido para autenticación y gestión de usuarios
- **stakes**: Logger compartido
- **bg_cop**: Configuración de RuboCop compartida
- **wisper**: Para eventos entre engines

### Convenciones de API

#### Rutas
- Todas las rutas usan UUIDs, no IDs internos
- Formato: `/chat/v1/recursos/:uuid`
- Nunca exponer IDs de base de datos

#### Respuestas
- Usar Jbuilder para todas las respuestas JSON
- Texto en español colombiano
- Estructura consistente para errores:
  ```json
  {
    "error": "Descripción del error",
    "detalles": {}
  }
  ```

## Testing

### Factories
Las factories están en `spec/factories/` y se comparten automáticamente con otros engines que dependan de chat_engine.

Para usar factories de otros engines:
```ruby
# En spec/support/factory_bot.rb
UsersEngine::TestHelpers::Factories.include_factories
```

### Request Specs
```ruby
# spec/requests/chat_engine/v1/example_spec.rb
require 'swagger_helper'

RSpec.describe 'Chat API', type: :request do
  path '/chat/v1/rooms' do
    get 'Lista salas de chat' do
      # ...
    end
  end
end
```

## Integración con Otros Engines

### Eventos Wisper
El engine puede publicar y suscribirse a eventos:

```ruby
# Publicar evento
broadcast(:room_created, room)

# Suscribirse (en config/initializers/listeners.rb)
Wisper.subscribe(ChatEngine::SomeListener.new)
```

### Overrides
Para extender modelos de otros engines, crear archivos en `app/overrides/`:

```ruby
# app/overrides/users_engine/user_override.rb
UsersEngine::User.class_eval do
  has_many :chat_rooms
end
```

## Notas Importantes

- No incluir `# frozen_string_literal: true` en archivos
- Usar UUID7 para generación de UUIDs
- Todo texto de cara al usuario en español
- Nunca exponer IDs internos en APIs
- El engine debe ser aislado, comunicarse vía Wisper
- Actualizar UPGRADING.md con cambios incompatibles
