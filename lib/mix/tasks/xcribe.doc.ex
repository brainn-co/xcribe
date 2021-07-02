defmodule Mix.Tasks.Xcribe.Doc do
  use Mix.Task

  @requirements ["app.start"]

  @mix_test_opts ~w[--only xcribe_document --formatter Xcribe.Formatter --max-failures 1]

  def run(_opts) do
    Xcribe.Config.override(:active?, true)

    if Mix.Project.umbrella?() do
      Mix.Task.run("test", add_umbrella_app_path(@mix_test_opts))
    else
      Mix.Task.run("test", @mix_test_opts)
    end
  end

  defp add_umbrella_app_path(opts) do
    app_name = :finbits_api

    case Mix.Project.deps_paths()[app_name] do
      nil -> Mix.raise("Couldn't find path for umbrella app #{app_name}")
      path -> [path | opts]
    end
  end
end
