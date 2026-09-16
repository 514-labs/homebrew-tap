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
  version "0.5.1050-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1050-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5615915347fdd1862e71342b3da655ab45936d3d64d87125cefda46157a6787e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1050-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "97dfd15d7247409be2059cdd7bd381a36da31ab867fc03cac6fff723e32e5fa4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1050-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fb922235746da1e6bf0a9a4cd5f54c1b57c9afc4d460a9ebabc639c155571e9a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1050-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "10dd01f8785d79a530ce7c61c918c1a9a7c91321fb05e7299a7ff74774b0c70c"
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
