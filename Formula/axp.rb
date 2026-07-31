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
  version "0.5.562-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.562-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "935d2407f71f8aeac6670d2a9db98ae853b33aa5d95466863def8a26234bddba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.562-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0f36db276a2d3c4c83c0ee83d2c8f9885ed042990429ba9041d396a64992fc7c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.562-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fe306b819d088e91a17ded33722d0fa26a1bc8f01db048b54468b60ba4a471e9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.562-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "145ea6161c26c42670de45448f868f0a81f3b2292b263ba5b3348cc199c1bc7a"
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
