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
  version "0.5.936-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.936-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8ab5e4df938329c4d27666180105d275e3531d972d4e37284910c0fa8b829e90"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.936-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a8d66103e815b75abb7286a9091179357180e7bbde039f730e16f23514485f06"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.936-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8cad63d94dbbfd13012294d01ff7fa466b95d820aba96729846f6f26ab592391"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.936-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8fe5d364912a88e790e7f3dda0f0b1e945b9664926fadf728e6adc67339337d6"
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

      Learn how to use ax: `ax learn`
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
