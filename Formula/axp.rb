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
  version "0.5.620-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.620-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4f43e3ebbf96b38bab30acad65fcd509694f2ce46c94d0b23079f2a87e65bb4a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.620-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7b266a7b7dcc0db2d36e7ecd18b9d3ba866d1ec0930f7e50dae9b83999e2771e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.620-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fd070fe0e12920841b915e214ded6f8714efe76a06430d32994c34d84fe43f89"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.620-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f2712ab832fd74d22994e1de24c30863f0caef73dbda0efaa3cbcc3d8ef2dc37"
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
