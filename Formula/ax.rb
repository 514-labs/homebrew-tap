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
  version "0.5.693-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.693-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "607428a4b0f43c7013f6529a23f724c996fa2bb41122ce079bbfd5e63d60501a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.693-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2b49aab35bc65556ecb01213dbb9c7e0c4eb8edcec1eb834cb0365e432a80f19"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.693-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dbc292459b076cbb48160fb87e8f49c8147c919abc3123d90ce19098ef6f5771"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.693-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dd2d3817197e53e42708b44511492ba9231833463543cfbae67c909b45bc0e60"
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

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
      Already have experiments? `ax experiment list`
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
