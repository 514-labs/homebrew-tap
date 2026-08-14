# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.785-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.785-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f6631fe5a692f54c5d77f1468d7ec1641ad64940576d0b57c4c7ca3eb8ceba90"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.785-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ec538008de10f86d0712efcdb26f5b18332949fa132a0b42a40b6829f7b5dc0d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.785-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "624e17c10e11ae3e9c1de4f8b0ef676c9044d68f302f850301f8e2dce4a94f5a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.785-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "49f378aa9369dbbc9daab5787a8eb8462071062af26707817d7f92ced2b3d805"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`axp.tar.gz` = `axp` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
