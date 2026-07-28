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
  version "0.5.508-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.508-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "327d517f90272c45fc64a61e8424855ce87e2054047db3bd50ac9767fa8c29a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.508-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "08ee3eed768b1d7257e202c6c5ee7b4318c7af08c5bf76a1f23989f9649c9076"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.508-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ec1dce9c82f41beed2c38548f1f2c2cffd750444d52d523f9137c3e1a9717972"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.508-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e7cfb1b49f7ed8ccd5d2c23e9e4c10df284b8d93295dbf89964527399f7e0ff1"
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
