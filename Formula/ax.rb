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
  version "0.5.773-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.773-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "92a6932fd57eac2e8f8264ed466fd44a96bfc15fcb1aa9a747df897b451ca7ef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.773-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "030d20a7a769421b457e49a7e23d6692f084fab3efec653c50c675e03eef999d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.773-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "206aabc6ec732c4b5a9b6dab03c18fb167d7a6849d28a340b15e24176ec6216c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.773-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "68caf3c67b9363aab5f88b673a2798b436f683b1e88728bc559a6d2e594a5b92"
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
