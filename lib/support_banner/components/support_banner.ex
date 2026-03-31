defmodule SupportBanner do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  attr(:id, :string, default: "support-banner")

  # class overrides
  attr(:container_class, :string, default: "")
  attr(:panel_class, :string, default: "")
  attr(:ticker_class, :string, default: "")
  attr(:wallet_grid_class, :string, default: "")
  attr(:wallet_card_class, :string, default: "")
  attr(:toast_class, :string, default: "")

  attr(:wallets, :list, default: [])
  attr(:supporters, :list, default: [])

  def support_banner(assigns) do
    ~H"""
    <div id="copy-root" phx-hook="Copy"
         class={[
           "bg-gradient-to-r from-emerald-950/80 via-zinc-900 to-emerald-950/80 border-b border-emerald-800/40",
           @container_class
         ]}>

      <div class="max-w-7xl mx-auto px-4">

        <!-- Toggle -->
        <button phx-click={toggle_panel(@id)}
                class="w-full py-2.5 flex items-center justify-center text-sm font-mono text-emerald-400">
          SUPPORT THIS PROJECT
        </button>

        <!-- Panel -->
        <div id={@id}
             class={[
               "overflow-hidden max-h-0 opacity-0 transition-all duration-300",
               @panel_class
             ]}>

          <div class="pb-3 space-y-3">

            <!-- Ticker -->
            <%= if @supporters != [] do %>
              <div class={[
                     "relative overflow-hidden border border-zinc-800 rounded bg-zinc-950",
                     @ticker_class
                   ]}>

                <div class="flex gap-6 whitespace-nowrap px-4 py-2 hover:[animation-play-state:paused]"
                     style={"animation: ticker #{Enum.random(24..30)}s linear infinite;"}>

                  <%= for s <- Enum.shuffle(@supporters) ++ Enum.shuffle(@supporters) do %>
                    <div class="flex items-center gap-2 text-xs font-mono text-zinc-400">
                      <span class="text-emerald-400">●</span>
                      <span><%= display_name(s.name) %></span>
                      <span class="text-zinc-500">sent</span>
                      <span class="text-emerald-300 font-semibold"><%= s.amount %></span>
                      <span class="text-zinc-500"><%= s.asset %></span>
                    </div>
                  <% end %>

                </div>
              </div>
            <% end %>

            <!-- Wallet Grid -->
            <div class={[
                   "grid grid-cols-1 sm:grid-cols-2 gap-2",
                   @wallet_grid_class
                 ]}>

              <%= for w <- @wallets do %>
                <div class={[
                       "bg-zinc-900 border border-zinc-800 rounded p-3",
                       @wallet_card_class
                     ]}>

                  <div class="flex items-center justify-between mb-2">
                    <div class="flex items-center gap-2">
                      <span class={"text-lg #{w.color}"}><%= w.icon %></span>
                      <span class={"font-mono text-sm font-bold #{w.color}"}><%= w.name %></span>
                    </div>
                    <span class="text-xs text-zinc-500"><%= w.symbol %></span>
                  </div>

                  <div class="font-mono text-xs text-zinc-600 break-all mb-2">
                    <%= w.address %>
                  </div>

                  <div class="flex gap-2">
                    <button phx-click={copy(w.address)}
                            class="flex-1 text-xs bg-zinc-800 hover:bg-zinc-700 rounded px-2 py-1">
                      Copy
                    </button>

                    <%= if w.uri do %>
                      <a href={w.uri}
                         class="flex-1 text-center text-xs bg-zinc-800 hover:bg-zinc-700 rounded px-2 py-1">
                        Open
                      </a>
                    <% end %>
                  </div>

                </div>
              <% end %>

            </div>

          </div>
        </div>

      </div>

      <!-- Toast -->
      <div id="copy-toast"
           class={[
             "pointer-events-none fixed bottom-6 left-1/2 -translate-x-1/2 bg-zinc-900 border border-zinc-700 text-zinc-200 text-xs px-3 py-1.5 rounded opacity-0 transition",
             @toast_class
           ]}>
        copied
      </div>

    </div>
    """
  end

  defp toggle_panel(id) do
    JS.toggle(
      to: "##{id}",
      in: {"transition-all duration-300", "max-h-0 opacity-0", "max-h-[600px] opacity-100"},
      out: {"transition-all duration-300", "max-h-[600px] opacity-100", "max-h-0 opacity-0"}
    )
  end

  defp copy(text) do
    JS.dispatch("phx:copy", detail: %{text: text})
    |> JS.show(to: "#copy-toast", transition: {"transition-opacity", "opacity-0", "opacity-100"})
    |> JS.hide(
      to: "#copy-toast",
      time: 1000,
      transition: {"transition-opacity", "opacity-100", "opacity-0"}
    )
  end

  defp display_name("anon"), do: "anon_" <> Integer.to_string(Enum.random(100..999))
  defp display_name(name), do: name
end
