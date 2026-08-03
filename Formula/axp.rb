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
  version "0.5.603-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.603-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "dd0697057a5ea0ce82f37bb08f8cc81b1cdee54ba831c747262f3380c98c7f18"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.603-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "55fe8686424f6de9c82068eaf8ae44315b3da6adfa097fc9ec66acb60164f1bc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.603-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1c6b321e8950bef872de56d8e5f9bd155588c2de45c319b1ef0fe4351285e05c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.603-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f6bcde138cae1a9539733c173d8fbff970dcbe22c625fddbddaa4f598a45b68f"
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
