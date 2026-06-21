class Lazyports < Formula
  desc "Visual TUI port manager for Mac, Linux, and Windows. Auto-detects project, multi-kill, 9 categories."
  homepage "https://github.com/ander0code/lazyports"
  url "https://github.com/ander0code/lazyports/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "f9913cb46be6f97ef569c51aa819bda72dc8fc0780c839f719a0f0c1234a01a9"
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
