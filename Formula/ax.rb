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
  version "0.5.469-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.469-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "aaa695c9693715b281afd39f59b1fb3e4b7d95cd6e7f45d834031a85e4721f2e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.469-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a9763d1143395e7cde3498dbfd77b04466f6ce9ecfbed4b937c328196689cf14"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.469-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "43de211d6593354d871109e09531b4e0e1f776db54e97956d7a5f07552d03858"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.469-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "49648fdda589c14b57aef2df58c9c55d68a22ece7d7814b63423d26955ebfde2"
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
