require_relative 'exchange'
    class Topic < Exchange
        def exchange
            channel.topic("#{exchange_name}")
        end
    end
