defmodule Mix.Tasks.SupportBanner.Install do
  use Mix.Task

  @shortdoc "Installs SupportBanner JS assets"

  def run(_) do
    app_js = "assets/vendor/support_banner.js"
    app_css = "assets/vendor/support_banner.css"

    File.write!(app_js, js_template())
    File.write!(app_css, css_template())

    Mix.shell().info("✔ SupportBanner JS hook created at #{app_js}")
    Mix.shell().info("✔ SupportBanner css created at #{app_css}")
    Mix.shell().info("👉 Now import it in app.js/app.css")
  end

  defp js_template do
    """
    const SupportBanner = {
      mounted() {
        this.handleEvent("phx:copy", ({ text }) => {
          navigator.clipboard.writeText(text)
        })
      }
    }

    export default SupportBanner;
    """
  end

  defp css_template do
    """
    @keyframes ticker {
    0% { transform: translateX(0); }
    100% { transform: translateX(-50%); }
    }
    """
  end
end
