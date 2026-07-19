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
  version "0.5.296-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.296-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "02e6aaeffae45c1a161db46b1bf5aac6366f2e6e9bad557d6f935341b3b279ab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.296-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3e47792a9a6950789d4e8260b2ba2fb8076eaf4825e0cfc49f2074f06b72b8ad"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.296-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "911e77ef2e18d5598254d918e18a4ef55e11213c446ee1a917be9f1a069bf033"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.296-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f6a34fe0d395f155be870e3b283dabfdbec7ce4a96f72c482bebe954bb54561d"
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

      Create and run your first experiment:
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
