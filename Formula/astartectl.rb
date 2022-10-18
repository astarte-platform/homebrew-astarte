class Astartectl < Formula
  desc "Astarte command-line client utility"
  homepage "https://astarte.cloud"
  url "https://github.com/astarte-platform/astartectl/archive/v1.0.0.tar.gz"
  sha256 "696782652e4bcefe61fc2007ce62d7f4f86725ec0e51a008111ec32757d39740"

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
