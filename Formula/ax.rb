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
  version "0.5.450-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.450-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2427529642f275039f48071458af475bcd8589889e7a3e7a8e3fe5727722debf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.450-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fe3caa31ab521986c45bb92042d631da2041b434e50c652d12ab6cdc246b98ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.450-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "37cb33ab094c3d034077a544905c3ea0ed285d7c8dda578689f5896a1a9e0a3d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.450-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "760a8af31761d8bb4d9ec63191e88b3ea886e2565e7ddfa168bb1d67ac600f72"
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

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
