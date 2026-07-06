class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 34 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/514-labs/dnsglobe"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.3.0/dnsglobe-aarch64-apple-darwin.tar.xz"
      sha256 "b72e6a140e5fd7a0fbcfc7d5475f15ea0e9bd8eff20489fc5ae1fb8b6d13c351"
    end
    if Hardware::CPU.intel?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.3.0/dnsglobe-x86_64-apple-darwin.tar.xz"
      sha256 "b0b33e916edf394a4aaecff5e6680606ab3e0960b22c80edb71b7d8d04972fa6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.3.0/dnsglobe-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "41b415eb17b30322df0d70e3f67456089a76dea90810c86e36aa8875c08061ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.3.0/dnsglobe-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "08fe903926550d33f2d10a41a15dd9ed16a7ef806b1fcd0b28fb41e6be56db27"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "dnsglobe" if OS.mac? && Hardware::CPU.arm?
    bin.install "dnsglobe" if OS.mac? && Hardware::CPU.intel?
    bin.install "dnsglobe" if OS.linux? && Hardware::CPU.arm?
    bin.install "dnsglobe" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
