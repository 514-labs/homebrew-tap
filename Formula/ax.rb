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
  version "0.5.1054-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1054-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bee1ad0de33c2f241c8676495cd3449f1fc3d51650386c220a65077803b7b0f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1054-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ad1fbffb48e8b7fe627af8cd23753930ed213fa8489e2c83b335b793ed5cb705"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1054-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8c7b91ff2b3e1372e94c9d7984c4828a31d47ccfe7b77d79b6f87001202a3c96"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1054-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d493f753a869c7e521d38f70cb678f8b201303f57142f78a924551a8c4c69708"
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
