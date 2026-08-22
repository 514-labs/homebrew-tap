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
  version "0.5.845-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.845-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "78cbf776fe44885b3be5e5d59f6811cae23b3daf8bbf17251ede4fa851851197"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.845-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8fb823d1b6d0ec1dffd388164cc62a1c4f4997848377b2e913a132babdd3c17f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.845-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "41c15da4c92165fbcb09d29cd0726909bdb94fc67790627dff3352173b639c25"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.845-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "94c5f7db597d45ce0d9ac0bc62f5b0a382bc601e4cf2671210ac555340ddc8d5"
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
