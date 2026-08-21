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
  version "0.5.837-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.837-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "241482d3587fb722b792754057878bfc77292b624fdebfcba60c7d01b1c9faa5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.837-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b1265cb7df6f51dbf76f361c28bd6835aecd5f5f0220d01b482fefa442f0dc5d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.837-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ac38c65aedc34d49e9fbd23fb4e8fc152dcfe0cff194fe4427c510702d12d41b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.837-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "498a0c925a36754c01f57d23db8c64587919fb7566cd151ab4a3118d88671d82"
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
