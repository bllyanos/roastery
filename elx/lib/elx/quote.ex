defmodule Elx.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    field :author, :string
    field :quote, :string
  end

  @doc false
  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [:author, :quote])
    |> validate_required([:author, :quote])
  end
end
