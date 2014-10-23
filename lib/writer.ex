defmodule Glossolalia.Writer do

  @services     Mix.Project.config[:services]
  @servicetypes Mix.Project.config[:servicetypes]
  
  def start_link do
    sub = spawn_link &(accept/0)
    Phoenix.Topic.subscribe(sub, "write")
    {:ok, sub}
  end

  @doc """
  Entrypoint for the worker.

  Takes write events broadcast by relevant routing layers, and writes them
  accordingly.
  """
  def accept do
    receive do
     {name, event, data} -> # We're writing accept events here
        IO.puts "Got ourselves a write event!"
        service = @services[name]
        mod = @servicetypes[service[:type]]
        instance = %Glossolalia.Services.OPAL{url: service[:url], name: name}
        mod.write instance, event, data
      _ ->
    end
    accept
  end
  
end
