require_relative 'exchange'
    class Topic < Exchange
        def exchange
            channel.topic("#{exchange_name}", durable: true)
        end
    end
