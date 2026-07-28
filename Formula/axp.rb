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
  version "0.5.493-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.493-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0d6a676d89e0272a5e4cf3c909a1a4dc3916df8f939b488ec569935d9a9e6834"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.493-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "978a694e731eab83c9179396cbc6e42af63e14517430d07672e00c1534a67d2c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.493-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d28755167bc924bb36aae6d524d94b58911e22dc62bd643984a5bb3fd5bc0c96"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.493-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "624091ed8d46d867dfbb544cccc436e38bcdd298dc5156a649b69f05d1873f59"
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

      Create and run an experiment:
          ax experiment create my-experiment --template cli-install   # your agent writes the YAML from your product description
        → ax experiment validate ./my-experiment.yaml
        → ax experiment run ./my-experiment.yaml                      # smoke: 1 repeat per variant; scale with --repeat 5
        → ax experiment query <exp-id from run output> --metric testPassRate
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
