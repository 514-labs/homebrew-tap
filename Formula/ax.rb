# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.359-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.359-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dc0c87a1014b8a5200cd749bc734f80524d0756fc11d59ff50e8d94523b060fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.359-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cbb5c6522cfe812196baa77fb35703df4327ed002a46a139f2b5c2f8da0a43c4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.359-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4673d5468981931d32e9a5dd274af9184f0ab9d71ee3a3bb0c35f294b2c8a0ab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.359-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5cda572a3cb0407214ff118415774b57772ae686e1d624f7198d179a3077e842"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
    EOS
  end

  test do
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
