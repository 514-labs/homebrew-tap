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
  version "0.5.613-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.613-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "dd199a502933513cce60ce18408e0e10d37cf81e2c42a630fc34834a04155df8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.613-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9178c20327ac4c7403110d02154b642a078b98f1177d823491230784c40cbb21"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.613-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f98b5ff80ddd6059dd6835237158da2276ffdb75135ab1faa334ee699e44a524"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.613-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "61235aafd4dcb97083fb0e04bb1c1951bfe36fcecea08bac113e82447af84f59"
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
