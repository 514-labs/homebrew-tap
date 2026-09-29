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
  version "0.5.1181-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1181-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d783226e4473b6e89fc6b9793f5ced0277d2e84c3029c0b306526416aef52b41"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1181-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "67fd33b01111a608134b88e27c46dfa187f2bb73aafbe221158882a90a94a12d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1181-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f39b7131251c8cd54fc44f217814c70636dd2e688618462aa57882e1df45dd70"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1181-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6100e212416c812147be3e606628142e0374a1351c962335cffb11a143249069"
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
