defmodule Glossolalia.Services do
  
  @moduledoc """
  Base mixins for Glossolalia services
  """

  defmacro __using__(_) do
    quote do

      @doc"""
      Get a JSON response from the server
      """
      defp get_json(url) do
        HTTPoison.start
        case HTTPoison.get url do
          %HTTPoison.Response{status_code: 200, body: body} ->
            result = Poison.decode body
            {:ok, result}
          %HTTPoison.Response{status_code: 404} ->
            {:fail, "Not found :("}
        end
      end

      @doc"""
      POST some JSON data to the server
      """
      defp post_json(url, data) do
        IO.puts "Posting JSON to #{url}"
        {:ok, encoded} = Poison.encode(data)
        IO.puts "Data: #{inspect encoded}"
        HTTPoison.start
        case HTTPoison.request( :post, url, encoded ) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body} } ->
            {:ok, 200}
          {:ok, %HTTPoison.Response{status_code: 404, body: body} } ->
            {:fail, "Not found :("}
          {:ok, %HTTPoison.Response{status_code: status, body: body} } ->
            IO.puts "Failed with #{status}"
            IO.puts body
            {:fail, "Unexpected status code: #{status}"}
            {:error, err} ->
            IO.puts "Unknown error condition :("
            IO.puts "#{inspect err}"
          thing ->
            IO.puts "Don't know what this is: #{inspect thing}"
            {:fail, "Unknokwn thing"}
        end
      end

      def read(_) do
        {:fail, "Not Implemented"}
      end

      def write(_) do
        {:fail, "Not Implemented"}
      end

      def subscribe(_) do
        {:fail, "Not Implemented"}
      end

      def write(_) do
        {:fail, "Not Implemented"}
      end

      def publish(_) do
        {:fail, "Not Implemented"}
      end

    end
  end
  
end
