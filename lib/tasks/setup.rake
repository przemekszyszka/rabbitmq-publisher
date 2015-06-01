task :setup => :environment do
  connection = Bunny.new
  connection.start

  channel  = connection.create_channel
  exchange_fanout = channel.fanout('currencies.fanout')
  3.times { |i| channel.queue("currencies.queue_#{i + 1}", durable: true).bind(exchange_fanout) }

  direct_exchange = channel.direct('currencies.direct', routing_key: 'acknowledgements')
  channel.queue('currencies.acknowledgements', durable: true).bind(direct_exchange)
  connection.close
end
