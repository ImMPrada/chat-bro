# ChatEngine

Motor Rails para funcionalidad de mensajería y chat en tiempo real. Provee salas de chat, mensajes y capacidades de comunicación en tiempo real para aplicaciones bro-garden.

## Uso

Sigue estas instrucciones para integrar el motor en una aplicación Rails:

- El motor se distribuye como una gema, que puede incluirse en cualquier aplicación Rails de bro-garden agregándola al Gemfile:

```ruby
source "https://rubygems.pkg.github.com/bro-garden" do
  gem "chat_engine"
end
```

Asegúrate de configurar tu token de GitHub. Revisa esto [https://app.clickup.com/9011060718/v/dc/8chkqze-2471/8chkqze-2111](https://app.clickup.com/9011060718/v/dc/8chkqze-2471/8chkqze-2111).

- Instala la gema:

```bash
bundle install
```

- Monta el motor en el archivo routes.rb de la aplicación:

```ruby
Rails.application.routes.draw do
  mount ChatEngine::Engine => "/chat"
end
```

- Ejecuta las migraciones del motor:

```bash
bin/rails chat_engine:install:migrations
bin/rails db:migrate
```

### Configuración

El motor puede configurarse creando un inicializador en la aplicación host. Las opciones disponibles se pueden ver en [lib/chat_engine.rb](lib/chat_engine.rb). Aquí hay un ejemplo de inicializador:

```ruby
# config/initializers/chat_engine.rb

# Ejemplo de configuración futura
# ChatEngine.some_config_option = true
```

## Configuración Local

Para configurar el motor localmente, clona el repositorio y ejecuta los siguientes comandos:

```bash
# instalar dependencias
bundle install

# ejecutar las migraciones del motor
bin/rails db:create
bin/rails db:schema:load
```

El repositorio contiene una aplicación Rails ficticia que puede usarse para probar el motor. La aplicación ficticia puede usarse como cualquier aplicación Rails típica:

```bash
# iniciar el servidor
rails server

# iniciar consola rails
rails console

# ejecutar pruebas
bundle exec rspec

# ejecutar rubocop
bundle exec rubocop

# ejecutar brakeman
bundle exec brakeman

# ejecutar bundle-audit
bundle exec bundle-audit
```

El motor estará disponible en `http://localhost:3000/chat`.

### Ejecutar el Motor en una Aplicación Rails Local

Para ejecutar el motor en una aplicación Rails local, agrega la siguiente línea al Gemfile:

```ruby
gem 'chat_engine', path: 'ruta/a/chat_engine'
```

Luego sigue las instrucciones de Uso anteriores para integrar el motor en la aplicación si aún no lo has hecho.

## Contribuir

Las instrucciones de contribución van aquí.

## Licencia

La gema está disponible como código abierto bajo los términos de la [Licencia MIT](https://opensource.org/licenses/MIT).
