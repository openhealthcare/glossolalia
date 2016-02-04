defmodule Glossolalia.Repo.Migrations.CreatePatientIdentifier do
  use Ecto.Migration

  def change do
    create table(:patient_identifiers) do
      add :source, :string
      add :identifier, :string
      add :status, :string

      timestamps
    end

  end
end
