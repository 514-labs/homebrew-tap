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
  version "0.5.604-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.604-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "44221c202db3de4bae829bccc9b081341a8be4c68108fca0d9a1fd3260176b6b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.604-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "13248464a344481cc378f5179b81a2545c7a5f751bbf65126f20c4a16caa1810"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.604-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2153f0cdd6558035e34d899bdee78c09144180e8706e57bfdc6cccf3b4cceb75"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.604-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6cfa1011f777794460aeb826af263752114c61e0a4907da074c49394d7823f6d"
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
