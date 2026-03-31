# Support Banner

A Phoenix component for integrating a donation/support banner into your Phoenix applications.

## Installation

1. Add `support_banner` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:support_banner, ">= 0.0.0"}
  ]
end
```

2. Run `mix deps.get` to install the package.

## Usage

1. In your `app.js`, import and set up the SupportBannerHook:

```javascript
import SupportBanner from "./support_banner"
const liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {
    _csrf_token: csrfToken,
  },
  hooks: {
    ...SupportBanner
  },
});
```

2. In your `app.css`, import and set up the SupportBanner css:
```css
@import "../vendor/support_banner.css";
```

## License

This project is licensed under the MIT License.

