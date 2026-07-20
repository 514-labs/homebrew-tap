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
  version "0.5.316-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.316-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "817cf4e751787888053029ddac7e02e9f0979e283d5ae046dd57a106118fff55"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.316-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2f689ac62105e3a8725ff0887f5265c167ca9109c23bbbf8a325e30fb581d62c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.316-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6a077cb99cd9d63dc0e129fbdaf80b429969d81f9acd65ba9dcae05728c5bab7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.316-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "883bd01e77d110e1c6a1480a56d65a34bfa21665399486b073bbc98cc9afa396"
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

      Create and run your first experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
