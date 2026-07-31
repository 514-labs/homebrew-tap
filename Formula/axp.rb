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
  version "0.5.558-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.558-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4cdff81500d0b780b580d08d57f7ee6975ceb5aae17817efb783fef38a928452"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.558-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ee9839b024202c20ec02e47b8314e37f7dbc833c86e426bb11b4e941cc306fc3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.558-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0928f0fc5bb7079391f1937a511caf98da17fbf828d998cbdc3799564eddee61"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.558-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3551424aba8a6a285267f86b1d94ff70b7a982946289cd533d6d93d388a49e9a"
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
