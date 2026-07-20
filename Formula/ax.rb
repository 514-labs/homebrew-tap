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
  version "0.5.305-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.305-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "12ffaa34300a92d52f8268d4b07394d404b194d913c4b336f9840144d2e51657"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.305-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0663339b0efdbf6f1452488f36b8489971c8fb48337f9d05503ae99cebac395d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.305-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "10c731026aaf2000f59b48ad813a3d2e228287ae16b766d3ed22bdc035469d27"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.305-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "40a3611e7d64cbe077c4d0fd3e57e1972e58d778c0ae989dab6908c760dc76bc"
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

      Create and run your first experiment:
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
