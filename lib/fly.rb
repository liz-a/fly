require 'bunny'

module Fly
    attr_reader :exchange_type
    private :exchange_type

    Dir[File.join(__dir__, 'exchanges', '*.rb')].each { |file| require file }

    def self.set_exchange(type:, name:)
        @exchange_type = type.classify.constantize
        @exchange = @exchange_type.new(name)
    end

    def self.bind_queue(queue_name: 'default', routing_key: 'default', durable: true)
        exchange.bind(queue_name, routing_key, durable)
    end

    def self.notify(payload:, queue_name: false, routing_key: 'default')
        if exchange.class == Fanout
            exchange.notify(payload)
        else
            exchange.notify(payload, (queue_name || routing_key))
        end
    end

    def self.exchange
        @exchange = @exchange || Default.new
    end
end
