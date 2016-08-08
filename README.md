# Tackle

Tackle everything with Elixir!
Tackle is a simplified AMQP client.

## Installation

Add the following to the list of your dependencies:

``` elixir
def deps do
  [
    {:tackle, github: "renderedtext/ex-tackle"}
  ]
end
```

Also, add it to the list of your applications:

``` elixir
def application do
  [applications: [:tackle]]
end
```

## Publishing messages to an exchange

To publish a message to an exchange:

``` elixir
options = %{
  url: "amqp://localhost",
  exchange: "test-exchange",
  routing_key: "test-messages",
}

Tackle.publish("Hi!", options)
```

## Consuming messages from an exchange

First, declare a consumer module:

``` elixir
defmodule TestConsumer do
  use Tackle.Consumer,
    url: "amqp://localhost",
    exchange: "test-exchange",
    routing_key: "test-messages",
    service: "my-service"

  def handle_message(message) do
    IO.puts "A message arrived. Life is good!"

    IO.puts message
  end
end
```

And then start it to consume messages:

``` elixir
TestConsumer.start_link
```

## Rescuing dead messages

If you consumer is broken, or in other words raises an exception while handling
messages, your messages will end up in a dead messages queue.

To rescue those messages, you can use `Tackle.republish`:

``` elixir
dead_queue_name = "my-service.test-message.dead"

options = {
  url: "amqp://localhost",
  qeueu: dead_queue_name,
  exchange: "test-exchange",
  routing_key: "test-messages",
  count: 1
}

Tackle.republish(options)
```

The above will pull one message from the `dead_queue_name` and publish it on the
`test-exchange` exchange with `test-messages` routing key.

To republish multiple messages, use a bigger `count` number.
