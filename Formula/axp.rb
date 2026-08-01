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
  version "0.5.580-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.580-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c95d2f921ace06cfad5533b43f1aba83887dc8de6577dc0998ea0eae6f95e039"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.580-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "357ce854798ed933e1dc5a30557a94f8ff32905ffb9449c1bfcd0000a641c031"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.580-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6cf49ed1cf56b2c993ba32716afce03b33fc1b5af9efe9718a7f52407d5c4db5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.580-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9523b281fac458fd08f7e3ba34c84e2db4509e284e891e185e43ca321b55e5a1"
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
