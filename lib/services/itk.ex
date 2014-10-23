defmodule Glossolalia.Services.ITK do
  use Glossolalia.Services

  defstruct url: 'http://localhost:7000', name: "Just another ITK instance"

  @encoding Glossolalia.Encodings.HL7
  
end
