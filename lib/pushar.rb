require "pushar/engine"

module Pushar

  def self.config(&block)
    @@config ||= Pushar::Engine::Configuration.new

    yield @@config if block

    return @@config
  end
end
