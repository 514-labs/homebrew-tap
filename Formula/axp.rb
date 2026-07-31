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
  version "0.5.570-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.570-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "36ba888b4136af3bc157e318139a7e941ddc88875a42deed1177bef3b00cf37a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.570-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f819a994878d61cae10424c4bbe2c42eb200cbeebd6ca8f1dfd64cb1c936f126"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.570-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "12af876cf3a014553df4cdfbd9f2c36b0266f4edacca20deb87825e21ec6f307"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.570-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "260547608310ef80801571e200afcb42383f5e91a93a54ae5c770fb5bf52b288"
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
