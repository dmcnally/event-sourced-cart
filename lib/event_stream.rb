require 'oj'

class EventStream
  class << self
    def event_type(event)
      event.class.name.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    def serialize_event(event)
      # build a hash of attributes
      attributes = event.instance_variables.each_with_object({}) do |key, result|
        result[key.to_s[1..-1]] = event.instance_variable_get(key)
      end
      # add type attribute
      attributes = attributes.merge(type: event_type(event))
      # serialize to JSON
      Oj.dump(attributes))
    end
  end

  def initialize(producer:, topic:)
    @producer = producer
    @topic = topic
  end

  def push(event)
    @producer.produce(
      self.class.serialize_event(event),
      topic: @topic
    )
  end
end
