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
  version "0.5.661-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.661-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d6f3abbac591cd533cb0682e7ec0a0b7ee45472f329864f810e1203a2ebf0a11"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.661-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1b9fc24dec7a8b19f3b2454324024a975512a31736447f84c01449ce69cb5512"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.661-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "96191da659b86a4622dec5dd10d888bc1dcd867348de61f237366fb739abacb3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.661-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8972c1b74ae790dfe2f635e69f6a0db5f51efa013132ef4a4ff6eddd2b5c4da0"
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
