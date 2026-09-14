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
  version "0.5.1038-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1038-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f917355677eda6ee744de715d291d44d267b0c20335cd9213fd3280fef36260e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1038-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "32f602c02c5d9986bd91d61bd86319fd859300a8f01f53cb65eb1005fd4ab533"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1038-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "033bf994f05bb660510c619e0d5830a6ba5be09b1c83616da0687f45f14cf377"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1038-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "541a93849aa902955c366a11bb3518ba00bdfb8db656c3fec677c9811a778787"
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
