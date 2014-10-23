defmodule Glossolalia.Services.DDD do
  use Glossolalia.Services

  defstruct url: 'http://localhost:4000', name: 'Just another DDD Instance'

  @encoding Glossolalia.Encodings.DDD

  def write(instance, event, data) do
    post_json "#{instance[:url]}/api/v0.1/#{event}/", data
    {:ok, "Sent to DDD"}
  end

end
