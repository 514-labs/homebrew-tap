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
  version "0.5.771-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.771-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d784ddc73afb53083cfc32382618302d26e5d58b69e0c4e43d1a9ac69779c39a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.771-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6f58ac3e62c312eae45e78d03765ff6997877cf958b291a1c50045d3e0fdc185"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.771-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "478ff297277e0a4add11b142f139b7c740a9a79b0a7fe8532e04cf9d8663c940"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.771-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a0f80ebfd3da1f8470ac911b9b40ff13360d922632c7b6861561d03e9470b404"
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
