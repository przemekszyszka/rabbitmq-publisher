class Publisher
  def self.publish
    Rake::Task['setup'].invoke

    exchange = channel.fanout('currencies.fanout')
    exchange.publish(OpenExchangeRatesFetcher.new.fetch_currencies.to_json)
  end

  private

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.connection
    @connection ||= Bunny.new.tap do |c|
      c.start
    end
  end
end
