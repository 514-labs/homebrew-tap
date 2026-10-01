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
  version "0.5.1218-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1218-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "739d8b0eae8b1542152a5319b6d82ae5412b64f266313ce2ab5041bfa2aeedf4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1218-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a983ecc68c458a47bbfbe6d225cbb071a83fea1c921e2f283ae243fbf0115873"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1218-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d60d8ad0272cf0c53491057ee170ffc1ecd8b1223335fb2ac95cd48b6a11f19e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1218-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "98dec0d622cd5c3d85eb199e4664d51c66d8fbe23f42e0698b5f9a9758426c72"
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
