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
  version "0.5.606-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.606-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "007e9d25c203333c82b1d8d22f92ce92d23ca2f048a84ff5f6b42ee0454d9072"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.606-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4fb3ea18a648ee33e19891e8777a351ac90476b4fb9255386312d0d3a597955f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.606-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5221cfa39fb42b5a63bf82188fbaaceb0f15e553f295aa4a612b0f79fd035a31"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.606-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6362601462bf396838c097d6c39bd51149ec77e7963eacdb7c4284466132aa3e"
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

      Next: walk your first experiment with `ax learn quickstart`

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
