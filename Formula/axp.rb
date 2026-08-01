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
  version "0.5.582-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.582-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4af1f7b555ec6f87e23ad0f53ff1f50cd0984b82600f41f5eb112d11a63da79f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.582-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f928e3a8fb92b32bdf30014bd6c7044a23f718011458252954bbbcbeb19aa596"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.582-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "536698c2f1e622df96f762db9c143fa259c0479f8b3a426875f5d811786463ce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.582-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "32b974f2bce836d4cb5225c4bdd559cb1eff5d133d4f11a93eade8cbc24fcfdd"
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
