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
  version "0.5.1193-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1193-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2a5ed7843f052006ce1193c10f1417f223dcaa8f6950ac93ddd3a58fe2566b88"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1193-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8ae0299719e71be95999f54dd92237971f7c3cd16c396939d084cb7741191f51"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1193-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aca82d1586d6e72b35af9f51ff8f7d94324cb4770b0750f321cd881ae413b350"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1193-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6dc96b1d4c95cdea0a1b85112a97a3a65801295ee2921d83aad0fbed395c8d7d"
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
