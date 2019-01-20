
    class Exchange
        attr_reader :exchange_name, :connection, :channel, :queue, :payload, :routing_key
        private :exchange_name, :connection, :channel, :queue, :payload, :routing_key

        def initialize(exchange_name)
            @connection = new_connection
            connection.start
            @channel = connection.create_channel
            @exchange_name = exchange_name
        end

        def bind(queue_name, routing_key, durable = false)
            @queue = channel.queue(queue_name, durable: durable)
            queue.bind(exchange, routing_key: routing_key)
        end

        def new_connection
            Bunny.new
        end

        def notify(payload, routing_key)
            @connection, @payload, @routing_key = new_connection, payload, routing_key
            connection.start
            @channel = connection.create_channel
            exchange.publish(payload_as_json, routing_key: routing_key)
            connection.close
        end

        def payload_as_json
            {
                routing_key: routing_key,
                payload: payload,
                time_stamp: Time.now
            }.to_json
        end
    end
