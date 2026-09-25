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
  version "0.5.1142-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1142-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "82cf8d67d14a4190fa76b3316decd3137953e1535b9f81ba1a6a4ff8a87b864e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1142-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1f276aeecc78df903f98f3e010eb27648311a11d7d96d3dd0337bd8d1bdbf54a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1142-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "03359d020db708a7221c9ebcb1cd84d77a813b5ed620f767071b9110ad2b96fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1142-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "326b8e79200046ecf20453445ab4e3ae65e553a2016f8803aa33b40af97b444e"
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
