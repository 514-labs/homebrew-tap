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
  version "0.5.904-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.904-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bb8005547a27c194f1a6ff17cb8983493fa5060c34e93a2ea82284ace283eead"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.904-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9b182f9342e4bf1f35255e350c88c4004b16796e001b8e8f535eb8a1354f0f53"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.904-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f6038e8bd816476003010ac30ba8c6c07781108ab7b4544e07e8d082060f3d5d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.904-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ac17ae4b5ea16cac44343ae63f7dd45a688b8cc8dc7b4752e111875545bef9af"
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
