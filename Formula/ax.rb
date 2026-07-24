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
  version "0.5.423-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.423-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8b99838cc483e9617b06f64b530682b2601486f275286b6fba3d9cefc42c5fc2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.423-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bae1d96c751404c5b56f0ca4391f677787df75d80edf4d9532249bcd335b84ff"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.423-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cc27888c7a770c14136f3a6abc32653bd088e441c73bf00cb180c64a2eefa45d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.423-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0b3f888215c2a2f549ac492ce3f65c24cabf21453ce930e5e829f920a432ada5"
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
