require 'chat_engine/version'
require 'chat_engine/engine'

require 'jbuilder'

Dir[File.join(__dir__, 'chat_engine/test_helpers/**/*.rb')].each { |file| require file }

module ChatEngine
  # TODO: Uncomment when stakes gem is available
  # mattr_accessor :logger
  # @@logger = Stakes::Logs::Adapter.new([:rails])
end
