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
  version "0.5.587-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.587-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "69c2a4510c9e638c9af7a14e001049370211022a7c5685085ddc150664762a1b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.587-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8c25df85c557a6d202004e0999b49fcc787354f5445680e6c01278b0fd6d3c37"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.587-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7c9780705c07cdcd79d9f6b8e168d177ed8a9526e6d80e1eb4c1044f99a92899"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.587-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "040d3fe66b99bac62d45d20e0ba6e597cad2b3524ab5e06a34b305d1e03c95c5"
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

      Next: walk your first experiment with `ax learn quickstart`

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
