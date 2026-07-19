class Taco < Formula
  desc "Normalize all your commands by wrapping them in a taco"
  homepage "https://github.com/RobinMalfait/taco"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.0/taco-aarch64-apple-darwin.tar.xz"
      sha256 "d625322cc68124a542b48bfd1d825a4acf0ebceb58174f43a47ce956db831f82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.0/taco-x86_64-apple-darwin.tar.xz"
      sha256 "470e2276bb51796824f4ca9eae972e0b4907f8e7a04bf96be19949a4737003ba"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.0/taco-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "85b4ee895c9a9dd4800e6f1ac8a1f5c54ff094dd6268ab1a4b01392a205a37ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RobinMalfait/taco/releases/download/v0.1.0/taco-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4c54f08e91e07337c94c3fb9ba5802498fe1d6b9a8b1a478486dac8544cb3217"
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
