class Portspector < Formula
  desc "Visual TUI port manager with auto-detected project stack. Mac/Linux/Windows."
  homepage "https://github.com/ander0code/portspector"
  url "https://github.com/ander0code/portspector/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "82a47674aee34e7e5e096aef7cc193a64333c5ff9b2f49e1c54d070d555f1c92"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "-o", bin/"portspector", "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/portspector --version")
  end
end
