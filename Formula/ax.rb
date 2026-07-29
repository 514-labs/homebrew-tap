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
  version "0.5.526-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.526-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "14d33ae72de99caea32e5f0d7f82911935fbcbc28778c5d18e6688f64fdc8863"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.526-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c6655a3b8991bc50ddca40a2a10eaff61d4d93832fa588f805d6a32108f7b127"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.526-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7b9ec8ebda98369c10a6b6dcbb5e9d87cb4e1f479414c3b844016ea87dafb4f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.526-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d8686d15880f61c0b375e8bc14d02d74a770585c7ec75c15eb6ec2c6505ad535"
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
