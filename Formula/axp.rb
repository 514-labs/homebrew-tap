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
  version "0.5.591-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.591-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8bdac206d69c7755d0f50d8068cbb14e8c2993103ed7c5d2c3fe644dfc645930"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.591-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4ba3a490672665127e29a9dbc9ad16001d273ccda9909b5d485d14eaa75c8c18"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.591-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c3ac75e13857c939b96745ecba7001dae536e744f51bcf132c42757eb417e378"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.591-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "082f6a0e91a6bda78170d5864be3318671b53bd41501512d3df99d234e750628"
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
