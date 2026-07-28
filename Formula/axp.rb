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
  version "0.5.503-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.503-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9c17a4c62bef02cc7dc683f6d831f7102167fcc5358bb015d2c671aefa32511c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.503-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "243672fc97a3a4d9a37ae271864dddf2594612cb1ac8dc515b33dc95c002b432"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.503-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7e5985c330578077e78ef056c6d871a964c07ba051294a52ecf42b38388b4883"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.503-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "33b3f6cb552e14dd7abd33ce356cc1753b011a8925613ac84d1526fd447153a5"
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
