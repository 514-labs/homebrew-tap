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
  version "0.5.422-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.422-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d331653ea434de4af80f25dcd151df40da03b178d506094933285f9d61d66adb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.422-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "295ced952035deed27ab7bce2b683dfd79e36d3129d558fb22a792c8b9e76633"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.422-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e352845be9e155ee7bcffbe27d896ed4184e55768f7f4fc2f430d27ce57f644b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.422-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2119a8546f80010d3b14ee8041c0e3cf8a9005763fecf80bba4ffaba8c65507d"
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
