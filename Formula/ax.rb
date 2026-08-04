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
  version "0.5.649-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.649-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "496acbac21f1b190535bfc37d839e5a129f280cc8a75c72872ec303a98924562"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.649-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "87b8f014cff0d9a68bbfe6a0ec4629a4c16ee6047f7d9e0aab62695d60b3dd57"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.649-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "38f632ca2753ebff498707236c11558c428d29d66c5ff4c2177e4ea3d1171c57"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.649-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "43c49ecc290d08bb99b4563d802e29c595aa844c8a796fb7447052663897bf38"
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
