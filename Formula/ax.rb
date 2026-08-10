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
  version "0.5.731-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.731-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "476993fce84a5065e24d72f02e312f9b16bc5d0ae3211c0304daf5d6c5847c5e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.731-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f1c44ce788388bfef73b36a18f1dfd5fe231d260e7a908bfa8af7c3af23df8a0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.731-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4a93a56d0607a072ac500ab56309c19ce2565d7e3b7e797559e78f830f2efbb7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.731-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "874e1b84b990cda26818cd59c4407b609ede3b67b85a0875e3ffcaaabfa17445"
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
