# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.626-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.626-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7e8fc902b6f2d7427266d15f92c1dce0f5c7d8645c3654c0ec674452b2917d91"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.626-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bfc088157f685e0f13aa7ae88891e2c784c26aec4827ac7f1ecd74aa864e86fc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.626-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "157771e9efdd50f0a19383d963162ad9ab716aea86f7b90b964c5dd543a97723"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.626-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "61ea2dcdeb02b96ef7ac3bda79b0d50c47591f35c61aba4b0a092d33ff46caa1"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
