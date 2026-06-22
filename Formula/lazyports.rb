class Lazyports < Formula
  desc "Visual TUI port manager with auto-detected project stack. Mac/Linux/Windows."
  homepage "https://github.com/ander0code/lazyports"
  url "https://github.com/ander0code/lazyports/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "72152c0c609c26c1a23a59f4321741c84328fbebfed7808e32ba1d097aa70114"
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
