defmodule Glossolalia.Accepter do

  @services     Mix.Project.config[:services]
  @translations Mix.Project.config[:translations]
  
  def start_link do
    sub = spawn_link &(accept/0)
    Phoenix.Topic.subscribe(sub, "accept")
    {:ok, sub}
  end

  @doc """
  Predicate method to determine whether a service of TYPE called
  NAME has been registered with us.
  """
  defp service_exists?(type, name) do
    Keyword.has_key(@services, name) && @services[name][:type] == type
  end

  # TODO: Find better word for type
  @doc """
  Return SERVICE's :accept translation(s) for TYPE
  """
  defp translations(service) do
    Enum.filter @translations[service], &(&1[:from] == :accept)
  end

  @doc """
  Perform translations for the service NAME
  which has accepted EVENT with DATA
  """
  def translate(name, event, data) do
    to_translate = translations name
    Enum.each to_translate, fn({service_name, output_type}) ->
      Phoenix.Topic.broadcast to_string(output_type), {service_name, event, data} 
    end
  end

  @doc """
  Entrypoint for the accepter worker.

  Takes accept endpoints broadcast by our HTTP controller and figures out
  if we need to process the message further.
  """
  def accept do
    receive do
      {:OPAL, event, name, data} ->
        IO.puts "OPAL event!"
        case service_exists? :OPAL, name do
          true -> 
            translate name, event, data
            {:ok. "found"}
          false ->
            {:fail, "Unregistered or badly configured service accepted"}
        end
      _ ->
    end
    accept
  end
                           
end
