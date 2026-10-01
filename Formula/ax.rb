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
  version "0.5.1210-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1210-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "510f78e78f2edb33bb7c1467ed68b9eb818962f7fedc696404791a7a1e07e303"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1210-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "75ca388d67e408590cb1a5094e95da8df5d4cb6cb1dc8e622d8ed46a311bed09"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1210-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4415fb258a7d35b71f839b4e550222cbb3765dae2a7b7d5474ef820d47fcc1c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1210-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8520ef5d05c01cb1cf54b112f17238bc5d9184226830c2cfb6fa278060b31cee"
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
