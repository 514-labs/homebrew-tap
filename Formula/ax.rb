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
  version "0.5.1125-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1125-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e1ce75541b8d79d4b031e9c8d1a8ba6d351389a51b9686db54258b49c25fe72d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1125-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c841928edf7f99ede2b1f8b9681f999513c609b16685d5cabd57a137208299b0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1125-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1623a9b74c8c29021d0c36a2acb20c477f080c54cf129899c045c8c4ae4e5201"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1125-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "96eb506780a2f751b161a2eeb9ac47abbdc5d5a9bac8334fbb4a89e12af2772c"
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
