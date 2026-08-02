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
  version "0.5.594-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.594-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "37fa9fe33d482051a88646e984308f682c77468782de4993550b110c391e94a5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.594-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "74d7171f90349d0690c8a2916a59d38d258b2743b644393530e9adba6f7151f7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.594-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "439df1eb4b8c91cc103f03da0160e141beaa427e666000be219e2037f9f2751d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.594-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dbcfb4e6874dba7b41b6146d73a584afe9f13d3fd0e9372505a9f56731689d93"
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
