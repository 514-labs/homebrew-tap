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
  version "0.5.1055-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1055-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "eba330c05068d4d0882fea7d07e3f66d4105d566ca46d8a6689bccf63c942b6f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1055-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "037b61ce1cd11325d506c0cca1f644116282c39531292d71273d8dc15b51b3d7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1055-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "58e7ccd6091e35fec3e5a5ffb760c1cf052bf8dc362fa884610adfd0c9e16564"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1055-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ebe01f5a69f3d6bd2bccf8eb69057d4d45a9ff26702ef1131681120f950944ef"
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
