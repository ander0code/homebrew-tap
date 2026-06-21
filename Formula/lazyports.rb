class Lazyports < Formula
  desc "Visual TUI port manager for Mac, Linux, and Windows"
  homepage "https://github.com/ander0code/lazyports"
  url "https://github.com/ander0code/lazyports/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "1b24ef5e9ab78b62741f52a34833d54884b283633a7ff5d4d737865c85bce302"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", bin/"lazyports", "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lazyports --version")
  end
end
