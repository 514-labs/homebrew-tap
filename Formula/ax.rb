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
  version "0.5.981-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.981-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "19dd6def655d358826ba9a2d194772e4c39fd0f53d97e1d0ae9a2795a2f8722f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.981-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d0a0b64bd20b768f46e36b39582a4f6fae15d0e88eeb84aba6c9a8194fcef9ac"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.981-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5669f5fd338853643cc0a18baa6557c787a4b257ab26841fc008816ed682ac11"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.981-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3a4d77383ed8f473bdcd89b5471ef07848fa6caaaeebb8e4f3c4371db6eb4ed0"
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
