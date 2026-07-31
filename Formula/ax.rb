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
  version "0.5.572-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.572-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "af8678142e8e5770981ed9d898beb1e22c0c1945e6f4202b713c03d0e0f23357"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.572-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d70cb13242bcbd4415943dc2490ba2288c97944c55f7910fcd240496cf024b9c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.572-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "32c26d7429bb14dcb80b6c05faa2ca4bcd608880c9462f545e3bd27a44aee305"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.572-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "401de863a15d8615e64223c17e89ed2b2394e0f0dc039d431bb5c3a3331e57ab"
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
