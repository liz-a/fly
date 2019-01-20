require_relative 'exchange'
class Fanout < Exchange
    def notify(payload)
        @connection, @payload, @routing_key = Bunny.new, payload, 'fanout'
        connection.start
        @channel = connection.create_channel
        exchange.publish(payload_as_json)
        connection.close
    end

    def exchange
        channel.fanout("#{exchange_name}")
    end
end
