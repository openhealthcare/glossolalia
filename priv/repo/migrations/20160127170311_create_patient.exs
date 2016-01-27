defmodule Glossolalia.Repo.Migrations.CreatePatient do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :hospital_id, :string
      add :nhs_number, :string
      add :patient_surname, :string
      add :patient_forename, :string
      add :patient_title, :string
      add :date_of_birth, :date

      timestamps
    end

  end
end
