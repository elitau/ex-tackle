defmodule Tackle.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tackle,
      version: "0.1.1",
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [applications: [:logger, :amqp], mod: {Tackle, []}]
  end

  defp deps do
    [
      {:amqp, "~> 0.3"},
      {:ex_spec, "~> 2.0", only: :test},
      {:logger_file_backend, "~> 0.0.10", only: :test}
    ]
  end
end
