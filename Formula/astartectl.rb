class Astartectl < Formula
  desc "Astarte command-line client utility"
  homepage "https://astarte.cloud"
  url "https://github.com/astarte-platform/astartectl/archive/v0.11.0.tar.gz"
  sha256 "974e003aa448619ff3a6fe42ff93cdf4f80d3a494c4b002b275c6f2085dfbaa0"

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
