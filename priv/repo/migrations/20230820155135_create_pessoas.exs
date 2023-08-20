defmodule RinhaElixir.Repo.Migrations.CreatePessoas do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
    execute "CREATE EXTENSION IF NOT EXISTS unaccent;"

    create table(:pessoas, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :apelido, :string
      add :nome, :string
      add :nascimento, :string
      add :stack, {:array, :string}
    end

    create unique_index(:pessoas, [:apelido])

    execute """
    CREATE OR REPLACE FUNCTION f_unaccent(text)
      RETURNS text AS
    $func$
      SELECT unaccent('unaccent', $1)
    $func$ LANGUAGE sql IMMUTABLE;
    """

    execute """
    CREATE OR REPLACE FUNCTION concatenate(
      stack TEXT[]
    ) RETURNS TEXT IMMUTABLE PARALLEL SAFE LANGUAGE SQL AS $$
    SELECT COALESCE(ARRAY_TO_STRING(stack, ' '), ' ') $$;
    """

    execute "CREATE INDEX pessoas_unaccent_idx ON pessoas USING GIN (f_unaccent(lower(apelido || ' ' || nome || ' ' || concatenate(stack))) gin_trgm_ops);"
  end
end
