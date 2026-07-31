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
  version "0.5.567-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.567-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d9c36d9132e8df1ead06790723553dddfb2d4c1713d015afc8d8b81fd67f3a45"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.567-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "efa3136107be88c25af74682727de44492d4248654402ec4ce16cccfbce6f662"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.567-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1db9758de1fea8b6cc09ba5746148031826a7fcfaa8d396ed01d56d2785aa755"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.567-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ebd0712d2b86687e72788b65ffc678a3f0a873a48641b53f7b9ba2b3eb3f0ec0"
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
