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
  version "0.5.911-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.911-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0173df4a201eaa6877b2c56ae3967918119e08f209af7fce7e761a2eb8062525"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.911-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cf4fb403329d761577538a86300198fc582ce08b137eddc70fa09d39b8d6311f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.911-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2317f47abc98603085268c04b1dec6146a86f45615562c7762a3a9798c62ed3b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.911-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3aebdf6f6849fb995a86d14ec75ee58ee3095b50919be3daf042500842859756"
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
