# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ai"
  version "0.5.48-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.48-rp/aarch64-apple-darwin/axp"
      sha256 "2b65ea12954b031598ab7dfd8ada20e9b89952e4e8f80b237bcac93a96cb9867"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.48-rp/x86_64-apple-darwin/axp"
      sha256 "b73a2342e1f8cfa70942364f5a11cc9f51123d60fda5ea18e723bb2aaaacc8e7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.48-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "cd72a0d9f82653d59bcc9b0df8fdc46617a49afd0cb02730700c53b69c54ea7b"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.48-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "cd7e3cde2a2c9cd70e32e902757579f9acae9b0b18691ca743a24f8c6bd887cd"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch binary, staged as
    # `axp` (the CDN object's basename); put it on PATH.
    bin.install "axp"
  end

  test do
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
