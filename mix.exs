defmodule SupportBanner.MixProject do
  use Mix.Project

  def project do
    [
      app: :support_banner,
      name: "Support Banner",
      version: "0.1.1",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: "A phoenix component for a support/donation widget"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_live_view, ">= 0.0.0"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mithereal/ex_support_banner"},
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE)
    ]
  end
end
