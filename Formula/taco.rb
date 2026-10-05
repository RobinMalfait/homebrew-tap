class Taco < Formula
  desc "Normalize all your commands by wrapping them in a taco"
  homepage "https://github.com/RobinMalfait/taco"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.2/taco-aarch64-apple-darwin.tar.xz"
      sha256 "8052346270d7b4b558433588ee09b8ab029465704d23bf64c415ee12e599a3ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.2/taco-x86_64-apple-darwin.tar.xz"
      sha256 "34b985bd048e790154d72315585bb6feb3f769618639a68d6d0d8d2ae883fd11"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.2/taco-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1be14f710d843f2c4c50b154b54e8e690e7960fed4fe7b9da049dec59df75f8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.2/taco-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c2500eb1527840d086a9dbb3f63935bdf8c91a799ab915bc8a1a22278661bb6f"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "taco"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "taco"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "taco"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "taco"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
