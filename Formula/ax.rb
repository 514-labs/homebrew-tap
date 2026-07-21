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
  version "0.5.327-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.327-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "61994bf3b65bc84bf98d3729192d6e43e89b2addf319bbdc2e309b38d044f841"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.327-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bd172848ad12f04d7fb6814414f8cab5c3b960c35c8b2db699361d865c7327d6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.327-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "af66bab3372d1e772b395ed5066be3697bc0ad1106985fa4bd0283c7e2ab0719"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.327-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d06f753ac9979a61cb128b7776684a68e47e9be231bd0262589ae4369573b2c6"
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
