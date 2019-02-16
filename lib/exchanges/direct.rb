require_relative 'exchange'
    class Direct < Exchange
        def exchange
            channel.direct("#{exchange_name}", durable: true)
        end
    end
