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
  version "0.5.1052-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1052-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2d0aff36403d67bba367533ae5ca96f0054d31ea5b48beafd0f132dcc41cf594"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1052-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9a07ac213b6b1570eae33699a9a49990fa5b94a0ab364772d9ecf0530ad2386c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1052-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9eb5fd5ef099b9367bd17ce0673ebd8c5e7fc74c382fac1e2b84e17d7bd8a6ce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1052-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2a42cea9322a21e1642e6ad31c1f57ec4d8a903cd5274abbfbaae8e79438c679"
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
