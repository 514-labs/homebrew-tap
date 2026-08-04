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
  version "0.5.639-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.639-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "116d370c6283c3684619655fdc98b8e7fa0310b0479c6e11866e3ff08f5c85d8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.639-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dc0c7cbb15433c514de6f2c2394d7e0c895593fd543e1f3641c10d2d408ed13d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.639-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "885b076dcff2bedad6e5efc25e04bdb52f34e87027fd1176cf7552d285c75c06"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.639-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a8631e3c211bf05fe237e1814c7be00ccfdfb1a26e63c108c6f6470964863afd"
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
