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
            {:ok, @encoding.decode result}
          %HTTPoison.Response{status_code: 404} ->
            {:fail, "Not found :("}
        end
      end

      @doc"""
      POST some JSON data to the server
      """
      defp post_json(url, data) do
        HTTPoison.start
        case HTTPoison.post Poison.encode(@endoding.encode data) do
          %HTTPoison.Response{status_code: 200, body: body} ->
            {:ok, 200}
          %HTTPoison.Response{status_code: 404} ->
            {:fail, "Not found :("}
          %HTTPoison.Response{status_code: status} ->
            {:fail, "Unexpected status code: #{status}"}
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
