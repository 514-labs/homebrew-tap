class Dnsglobe < Formula
  desc "Global DNS propagation checker TUI — watch a DNS record propagate across 34 public resolvers worldwide, on a world map in your terminal"
  homepage "https://github.com/514-labs/dnsglobe"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.5.0/dnsglobe-aarch64-apple-darwin.tar.xz"
      sha256 "a3a9d9e19f5457c46e49fa706e6540df42fff6b174e4df2bdf1c83d59caf39dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.5.0/dnsglobe-x86_64-apple-darwin.tar.xz"
      sha256 "4202ddf0fc37ee9a6889f33e495bc317197ed33cb37cedb604f2155faee6ed9b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.5.0/dnsglobe-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "95d3ad8e343fe8e4d34ab8b7a78dc42f2a9ff950ae141852f718314a6c3c717b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/514-labs/dnsglobe/releases/download/v0.5.0/dnsglobe-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b2b293972463deee845ffd7c1c1217eff645bfd5f7ec549d99ba830dc4c0b598"
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
