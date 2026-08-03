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
  version "0.5.618-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.618-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1c42ac06dfc8b5747bd3f86f218984bd69ccc60538cd8227a9a1d85ddd7e41d8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.618-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "59c989640efe3356c9a8ef194c3e1b99868b2c4c3636f95f7ef293d25b80713d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.618-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "baeea1d77f252226aa1c2fac1549b6d64d8710a48ce0650f55c54c539d35f4dd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.618-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "299b4dd0df06138e24493f01f08747678cbcc0ef565a55e2056a76cc74a4dfa7"
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

      Next: walk your first experiment with `ax learn quickstart`

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
