defmodule Glossolalia.Services.DDD do
  use Glossolalia.Services

  defstruct url: 'http://localhost:4000', name: 'Just another DDD Instance'

  @encoding Glossolalia.Encodings.DDD

  def write(instance, event, data) do
    case event do
      :change ->
        form = [pre: data["pre"], post: data["post"], endpoint: data["endpoint"]]
      _ ->
        form = [data: data]
    end
    post_json "#{instance[:url]}/api/v0.1/#{event}/", form
    {:ok, "Sent to DDD"}
  end

end
