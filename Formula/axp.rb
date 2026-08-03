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
  version "0.5.609-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.609-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "53e0283ddf4e6f93c54151ebcc8dd285bd8ef9eb5e2bd5adfdbe13a40913374d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.609-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "20d560cc01bc7088e1813009a8845bf1dade16041707befc19ccb1920ae2921c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.609-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "81422d0b0788a9c5c964270d88ff48e9ca8e2e454e2574eb446213607e5c4d2b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.609-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "83c503b5bd81f455fd4d8a68e10d3c01bd9163c6d7e17b66d7d5225f6d8a4805"
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
