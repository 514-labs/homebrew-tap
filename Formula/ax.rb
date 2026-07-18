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
  version "0.5.275-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.275-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "82bb520f76dd3f6633d2a310f67d435eea3eb5d370cd6a2a5daa5889e3bc524b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.275-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5502407bb01ce63e10f4755c3ea3b37b3271a3acc819bd72da83a68083034026"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.275-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "94c2a15fffd7b9a7631b390372f8ff8378eea42d7ca792775335959b3ae60ac9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.275-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fdab8f6e0021f48f6d4b9c2777a691dc46b4a87af8da25d3bafaef15b98473cc"
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
