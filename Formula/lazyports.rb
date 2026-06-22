class Lazyports < Formula
  desc "Visual TUI port manager with auto-detected project stack. Mac/Linux/Windows."
  homepage "https://github.com/ander0code/lazyports"
  url "https://github.com/ander0code/lazyports/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "f8f8b198a574ed1af1d3aa418982cdfc2d792c0a825940fb6ac29b38bb436bdf"
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
