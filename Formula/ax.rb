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
  version "0.5.1011-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1011-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "05fec94277268c6ddce703233bbc193f7b68327f5387ad5386869d6c0d78f3db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1011-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a58be21f61142d7bbe0f425228044dab74198db278317e5ffd0d7e58a5f5547a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1011-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "911e534548e4e488cb7664615f6f7a939a6c68f530e1e8ce66b2905aedd4956b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1011-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d12b94bc2055ebeb81e66594c76d175874a0e3c4713d8e26b25eb908bd4c1c51"
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
