class Astartectl < Formula
  desc "Astarte command-line client utility"
  homepage "https://astarte.cloud"
  url "https://github.com/astarte-platform/astartectl/archive/v0.10.3.tar.gz"
  sha256 "b2f2545c9e59e3c44d3ca2e2e56690fd4e24fd69770ae5d37079cec03986f15f"

  depends_on "go" => :build

  def install
    system "go", "build"
    bin.install "astartectl" => "astartectl"

    # Install bash completion
    output = Utils.popen_read("#{bin}/astartectl completion bash")
    (bash_completion/"astartectl").write output

    # Install zsh completion
    output = Utils.popen_read("#{bin}/astartectl completion zsh")
    (zsh_completion/"_astartectl").write output

    prefix.install_metafiles
  end

  test do
    assert_equal "Valid", shell_output("#{bin}/astartectl utils device-id validate 2TBn-jNESuuHamE2Zo1anA").strip
  end
end
