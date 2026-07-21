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
  version "0.5.347-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.347-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6676824b593dcb88d40943cde60d251fe037c06b107ddce4231caeb2bf404f2d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.347-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b2baf26665d04eecb7a53de74e5845b8b6ff873926f1c09a45be8e5b35508d55"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.347-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1479404eff98f1eadf42509ae8d6651ad174f57527dbb670e165ad45f51fe110"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.347-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "835e96094f74a872f61c6283fb8c52c020df16874197e2a215826556b19af9cc"
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

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
