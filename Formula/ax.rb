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
  version "0.5.840-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.840-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7e4b759e61dc1cbc7de978709b1a17e0925c3b051c2952267f7b3db160dc95f0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.840-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "38d33c1a70ab7753fc353ea6c461a233e7c6f1b8a7602a70ee45a82155543828"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.840-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "79902ab7b2bdabadb94c49fa65eb47f65d69a01a0c4974f0899cb975c68a3bab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.840-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fc3802517ce36f0ad4110c00040a575fc3f8e562f193bc8b59d836a3d0e6f529"
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
