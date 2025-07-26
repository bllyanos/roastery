defmodule Elx.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :author, :string
      add :quote, :text
    end
  end
end
