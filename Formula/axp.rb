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
  version "0.5.600-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.600-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9bb45d9d1ea5b58a91e671cc8962020ae2fea3b749f75e19c99c2ba0f71f7adc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.600-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7c41fdb28a53762de1c5e73492c971f00fcd8f7b770e005d15c4ba0e6e6fd70a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.600-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "61617fbe4d8ac4a9415584582e950194135b8f018e01aa00caa9669d7e50dadb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.600-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "17b8866aa3b678bc7938ce21b39d4bc44b6afee019ef15d659fe1b6375f711b8"
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
