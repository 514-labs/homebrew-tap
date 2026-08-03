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
  version "0.5.626-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.626-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "563293ca22a75e9ac8244df16f8192482599e3450dc5de23c414bfdca5fec56f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.626-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f030c389a84c6ac2d3728fcaed3db815001c112add901cf3ddf7c32d02cfc50c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.626-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "66ea9f129b3b1e79cc513aa104639eb8229c36f131fb0aefc9193523c45e7eb0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.626-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "63fe7c33c29ceb420ad6e9dfd47c808514ff4c7c04556bdd24d668a9d7e54dc5"
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
