defmodule Glossolalia.Accepter do

  @services     Mix.Project.config[:services]
  @translations Mix.Project.config[:translations]
  
  def start_link do
    sub = spawn_link &(accept/0)
    Phoenix.PubSub.subscribe(Glossolalia.PubSub, sub, "accept")
    {:ok, sub}
  end

  @doc """
  Predicate method to determine whether a service of TYPE called
  NAME has been registered with us.
  """
  def service_exists?(type, name) do
    Keyword.has_key?(@services, name) && @services[name][:type] == type
  end

  # TODO: Find better word for type
  @doc """
  Return SERVICE's :accept translation(s) for TYPE
  """
  defp translations(service) do
    IO.puts inspect(@translations[service])
    res = Enum.filter @translations[service], &(&1[:from] == :accept)
    IO.puts inspect(hd(res)[:to])
    hd(res)[:to]
  end

  @doc """
  Perform translations for the service NAME
  which has accepted EVENT with DATA
  """
  def translate(name, event, data) do
    to_translate = translations(name)
    IO.puts "Iterate through tranlations: #{inspect(to_translate)}"
    Enum.each to_translate, fn({service_name, output_type}) ->
      IO.puts "Service: #{service_name}"
      IO.puts "Output: #{output_type}"
      Phoenix.PubSub.broadcast Glossolalia.PubSub, to_string(output_type), {service_name, event, data} 
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
        IO.puts "Accepting an OPAL event from #{inspect(name)}!"
        IO.puts "Data is #{inspect data}"
        case service_exists? :OPAL, name do
          true ->
            IO.puts "Service found"
            translate name, event, data
            {:ok, "found"}
          false ->
            IO.puts "Service not found :("
            {:fail, "Unregistered or badly configured service accepted"}
        end
      _ ->
    end
    accept
  end
                           
end
