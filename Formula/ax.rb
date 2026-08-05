# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.653-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.653-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "eb2e0ce71456bad761a8e88f72a2402d5e1b88bdd39d2ccec8819ecc1b3f94aa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.653-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "459f4551b3e9ab7ab9cf14686deebf3f993f579b6abdd1b403994cd92933257e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.653-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8c8e1459fd179f835665ac59023c85c91a809ce632686b15c833480a708bd2cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.653-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ec3c8eccb27879d5a3e831e3ccc75267877043b51c823cdedc39dee0e51664e7"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
