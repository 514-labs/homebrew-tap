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
  version "0.5.891-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.891-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4d199beb3570fd003cd22899b6a46cf392240ba6b252165c22f451faf75c1aab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.891-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "915ec294043f45953915de331068c3de9c9331368a072204881604f61437af30"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.891-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d14d2e1ad45c1b1e5473f95da296911e6229d71b2cbea135a938b6a7995e7132"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.891-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e09794cbc2304be5477bc8b5a8137c1b66bac5ee87fd06631f9ebc80d7a00b59"
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
