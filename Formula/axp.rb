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
  version "0.5.577-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.577-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "16ddb50cc39c4d36199f771631dbe95fcfff9af3123fcdd8f1235bc34765a787"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.577-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "46a23b8e18ccc747086572ce8177b6634fbe13ce58020bbe0803054688574756"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.577-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ef9d62c81677378cad7fdb38069163512e063ce2d1e109ffa3b7665e737b46f2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.577-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bd161cab66ccb539518b9a1cbdaf30ba880cb07ca13f6f4d25f215b56603ce27"
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

      Next: walk your first experiment with `ax learn quickstart`

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
