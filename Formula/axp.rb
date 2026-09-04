# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.961-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.961-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6bd01287ea109ecd03a247e3a2b5f829593958bada085645a2a513aa6849eb0b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.961-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "83730334e09eafd70b0e64de2736dc2a7d4975a141cb5946dbc43fcbef8c32a4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.961-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a85d37c1a9ad0342ae51aadb51011aab1bb136ae5194acba440350943dccf9e6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.961-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5d325978210643f3c98478bdd666c1acbe54b250782ba642cb1f43164923d61b"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
