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
  version "0.5.916-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.916-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cd6a919ce0b64c23a946e89d867785560781c7a4c1abab4d66755afbc0f64c61"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.916-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "caad885585d4c4709525d3fc1f45b8d79fd38b33bdfadb2b8dbe0dbab3faf39f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.916-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d93f799dce9418d4b3a7b0a18ceeef0602553936f6048375e78b81b533198baf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.916-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d2456b9372ecb648ec06c2994042a757e559e78691d772be5967b42628e32dc3"
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
