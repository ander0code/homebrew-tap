class Lazyports < Formula
  desc "Visual TUI port manager with auto-detected project stack. Mac/Linux/Windows."
  homepage "https://github.com/ander0code/lazyports"
  url "https://github.com/ander0code/lazyports/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f82f79c807ac6300d14c0a2a0605b27a982c60014b9bfb97a9b581fa96c72d5c"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "-o", bin/"lazyports", "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lazyports --version")
  end
end
