defmodule Glossolalia.Services.OPAL do
  
  defstruct url: 'http://localhost:8000', name: 'Just another OPAL Instance'
  
  @encoding Glossolalia.Encodings.OPAL
  
  @doc"""
  Get a JSON response from the server
  """
  defp get(url) do
    HTTPoison.start
    case HTTPoison.get url do
      %HTTPoison.Response{status_code: 200, body: body} ->
        result = Poison.decode body
        {:ok, @encoding.decode result}
      %HTTPoison.Response{status_code: 404} ->
        {:fail, "Not found :("}
    end
  end

  @doc"""
  Return a patient's details
  """
  def read(instance, :patient, id) do
    get "#{instance[:url]}/api/v0.1/patient/#{id}"
  end

  @doc"""
  Return an episode's details
  """
  def read(instance, :episode, id) do
    get "#{instance[:url]}/api/v0.1/episode/#{id}"
  end

  
  @doc"""
  Accept POSTed data for various types of event
  """
  def accept(:change, data) do
    {:ok, @encoding.decode data}
  end
  
  # Accept POST 

  # Subscribe

  @doc"""
  POST episode data to the server to update said episode
  """
  def write(instance, :episode, data) do
    {:fail, "Not Implemented"}
  end
  
  # Publish

end
