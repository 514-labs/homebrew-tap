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
  version "0.5.574-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.574-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cb9270fefc853fa1f14d0d45e0bd8034abd4533379bd5442321f48ee38f6c05a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.574-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "04cb269932280f4124ea808e9d7680f70f6f07e7a8def9528876f66bf1c7ed45"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.574-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "66a81655d07460f4e9ded4f7e04969daec670a5166728ac170804179ba818ee4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.574-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5e226e049179bf700e1c34515e48474526b22dd3d24a591ad72410f93a04ceae"
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

      Next: walk your first experiment with `ax learn quickstart`

      Already have experiments? `ax experiment list`
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
