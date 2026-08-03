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
  version "0.5.608-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.608-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "37169e27288b0adefe4d4ae36ed19b8d6db38841f4a3488661a17df2c5b90147"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.608-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "86d2922660e1854bae33f4752b8c31441dd84401d942426daf317e9545934317"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.608-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "da16a267043648d591ef7dbec304dade9c2893e302ff1ef0fdb4e27e3b9c9f55"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.608-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "036e942f685ae04b73401e9f6d85b5744912da3447e051ae142964c36f9dbba7"
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
