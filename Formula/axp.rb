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
  version "0.5.610-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.610-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cb2086a090b9f5b6ff4701c9926bcec270f324a2aeafb80f2a9795b7eee3237c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.610-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5769824b9463c651cb2cafb1cacb5213ebc7d7f26d04a021bd14d4207173f7a4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.610-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4dbb4c5cd3f68f27b5a4aca92ca0175beb475148b9a2618451db26b44840079c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.610-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "88f9efaa434c2ac9d686a1bb677f810ab93b3026a7d93281a2ab3d3016dc5d71"
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
