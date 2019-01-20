class Default
    attr_reader :connection, :channel, :payload, :queue_name
    private :connection, :channel, :payload, :queue_name

    def notify(payload, queue_name)
        @connection, @payload, @queue_name = Bunny.new, payload, queue_name
        connection.start
        @channel = connection.create_channel
        queue = channel.queue(queue_name)
        channel.default_exchange.publish(payload_as_json, routing_key: queue_name)
        connection.close
    end

    def payload_as_json
        {
            queue_name: queue_name,
            payload: payload,
            time_stamp: Time.now
        }.to_json
    end
end
