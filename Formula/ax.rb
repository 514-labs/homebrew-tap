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
  version "0.5.612-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.612-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7bed719e36d6c15ff8ecda168ac0963ef1318914336982303403c555d69964c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.612-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "21843a9135f98af9995c4a051ce3aa97d9d09c8de10f2c8ad703931ba6abac15"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.612-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cdebd186fe64ff31e50f317fbe4fa9ce880549ce14ecd4b267318586b18a34f2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.612-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "49d2104453412122da19380be9e0b130fc8888bc6760b3f108916756cc1b37d0"
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
