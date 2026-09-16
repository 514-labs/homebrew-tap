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
  version "0.5.1050-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1050-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "11576f69ee38b3274330d548f7966a3058b878798a98144467d34f69fbf296da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1050-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "42014e58d9d4bedfd69b8e11459e0f4938087bbb8e618f694c9ae42e824bbf6d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1050-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fc089171def86f3c5807ab75b92ddbac5ea077070864ba286d1f2cfef918d6bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1050-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "335bcb5be407b8a0c12132a361eae23668d0176a065b92ae78e42fd6d4e4e4b8"
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
