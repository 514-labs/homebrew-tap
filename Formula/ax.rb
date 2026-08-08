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
  version "0.5.712-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.712-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e06d84d73125df70501d5517dbe6ecbd64fac6f03b67f3886ec3bafe77ddbe6c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.712-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fb8b36065e3e2b6d40977c69b3c2afefa7cd531e5dfa833a44b7248824fdcbff"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.712-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "60771b0d1f0787f1ccf55be7fb7b3f054e5d8760cf271ef12b321d211f8c44e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.712-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a88ab6f37f43320e1c5721c495aa90d4f949e0bc5cd5eb307bd9a47c57538583"
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
