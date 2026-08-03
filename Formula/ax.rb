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
  version "0.5.620-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.620-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c2e4f409986bb79a90b95c565beec95bfb6fabfe4964a072963e90f3d7a9b9db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.620-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "414b5f16ac78ff746560540168f9f710dc3e864944d747db6eccd28a6722140a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.620-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3ef6ccbe98c3a67e7fbb0d66214e98e7b9364952de9cb0e2467dbc0064054b7b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.620-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8c587dc50c0eeede02fb5c20c2792e4c0120eb56bdabbee0f6b56dc05b993536"
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
