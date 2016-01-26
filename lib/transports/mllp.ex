defmodule Glossolalia.Transports.Mllp do
  @behaviour Phoenix.Socket.Transport

  def default_config() do
    [window_ms: 10_000,
     pubsub_timeout_ms: 2_000,
     serializer: Glossolalia.Transports.Mllp.Serializer,
     transport_log: false,
     crypto: [max_age: 1209600]]
  end

  # def init

end
