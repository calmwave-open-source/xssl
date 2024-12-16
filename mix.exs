defmodule Xssl.MixProject do
  use Mix.Project

  def project do
    [
      app: :xssl,
      version: "27.2.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :runtime_tools, :os_mon, :public_key, :inets],
      mod: {:xssl_app, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end
end
