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
  version "0.5.812-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.812-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c452cf43647984fba697083e8d1bf82fd4fc1812879740dc356aea897db8f4fe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.812-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "394f16d186faacecf4ba393b34bff56f0e6a22f2b83b391fe1fae35e6afb943d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.812-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f3710e4dde324e5679d5188afd5d58b0158820798c6236cfd05123f14f82e85b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.812-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d09e54f03dd6ddf9a184248ab19a210876862ed73918aadb2b7cd5f5bdbd89d7"
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
