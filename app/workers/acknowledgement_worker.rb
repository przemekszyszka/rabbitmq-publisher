class AcknowledgementWorker
  include Sneakers::Worker
  from_queue 'currencies.acknowledgements'

  def initialize
    @retries = 5
    super
  end

  def work(message)
    acknowledgement = JSON.parse(message)

    begin
      currency = Currency.find(message['uuid'])
    rescue ActiveRecord::RecordNotFound
      (@retries -= 1).zero? ? reject! : requeue!
    end

    processed_by_consumer = "processed_by_consumer_#{acknowledgement['id']}"
    currency.update_attributes(processed_by_consumer, true)
    ack!
  end
end
