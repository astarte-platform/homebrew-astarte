class Astartectl < Formula
  desc "Astarte command-line client utility"
  homepage "https://astarte.cloud"
  url "https://github.com/astarte-platform/astartectl/archive/v0.10.4.tar.gz"
  sha256 "90364fae98418e696413bc9a7a3a8f59b32b53e1c98e86f44e76450cbc0f99fe"

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
