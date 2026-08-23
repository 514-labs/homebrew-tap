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
  version "0.5.858-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.858-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "499e906c4144a42344f6a649811c2f5dc6cb56a2b5754883e5a98aae50c4d382"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.858-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0b1b60995936b07523f89f44692eff0fc590c83d3a3858a945536f92581daa61"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.858-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8afa75918984ee90cf270d310e797a6c9c7570063c5aa0fbe40f42516012aa24"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.858-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "db2828829006372e1d19712788dd3ff8fe31024230e5ca5ebf049213dda5556d"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
      Already have experiments? `ax experiment list`
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
