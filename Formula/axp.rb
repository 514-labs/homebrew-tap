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
  version "0.5.754-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.754-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "191cf6fe4e2cef1acf0fc0abf71f7930634c8c69e09523615e10a78f40ca0d92"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.754-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "25181a77b8f199a5cbaf0f05bf83832e3cba14d1dd37ab39d74bf4aec2030647"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.754-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8c54c59c6f5d238a7fa5bf2079dff410a1643ef0a19518ec0c40d97cd35aa82b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.754-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "238d37a52cdb7eb7d72e7d5fd3f3caf2619a2bd9b6069c444716b857ba1aefd5"
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

      Learn how to use ax: `ax learn`
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
