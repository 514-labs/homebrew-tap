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
  version "0.5.788-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.788-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "335525ede7fe10007ced5cbcbef6562f0c2f41113194d22bf7b4a861d0a18bb1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.788-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "43b032a245ab1d2e137f16f16872abbf808ba91d9bce2fd4ededacd97e9aea4a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.788-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1a0ffa1436ea7429bea018b84939c3a23289cee3e58f76808d88b46dd9bc468f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.788-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f575a64b292802705949a59675ea787a3bb3f3e4a18eb2bc4913a68dff6bb102"
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
