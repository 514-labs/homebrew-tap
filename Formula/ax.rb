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
  version "0.5.976-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.976-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "777acb7389aae7e825d3c79593a9b41645b4637a3b5ab932518a90528991ac65"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.976-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "de6f56b39c6bdcf61910351e200efd4f7e1f944029fde1ac5cbf94505a6a6eef"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.976-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9595f8b5375c80b9e9eb4c1265034bc3b12fab108a85c4ded7c22850ed68fe7a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.976-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "06207bfecc2ebcc61cb838567c5166f529f3fde2e72b50b270f359f4c7574517"
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
