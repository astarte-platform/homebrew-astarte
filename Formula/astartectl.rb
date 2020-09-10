class Astartectl < Formula
  desc "Astarte command-line client utility"
  homepage "https://astarte.cloud"
  url "https://github.com/astarte-platform/astartectl/archive/v0.11.1.tar.gz"
  sha256 "1e6b1ad66430aaeeb075765004e01b3e16025fb1f26b932e66a029009aaef16e"

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
