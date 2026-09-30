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
  version "0.5.1203-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1203-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a223f1f642479de0ab0d0049a25a612a06cde105bfacfcd5244ac065070966fa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1203-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "513b89750ff51a46e43c300e8bc29ac4226ae8bc4a49766fef46eb58090f9c54"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1203-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a9b1bde73ddeb79fecdf2442e485f6abb46cad57661cee88dcddc22f931e36e6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1203-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8fb1b157bae2b0e2ae9e6b29d2df765d6e391a75998ae05ced25c3a034a4ce4c"
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
