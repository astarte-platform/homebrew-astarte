class Astartectl < Formula
  desc "Astarte command-line client utility"
  homepage "https://astarte.cloud"
  url "https://github.com/astarte-platform/astartectl/archive/refs/tags/v24.5.3.tar.gz"
  sha256 "c34a66600362f87efbd5d074dff0214a5cb723e409ba4de967c703a7f9efebd5"

  depends_on "go" => :build

  def install
    system "go", "build"
    bin.install "astartectl" => "astartectl"

    prefix.install_metafiles

    generate_completions_from_executable("#{bin}/astartectl", "completion")
  end

  test do
    assert_equal "Valid", shell_output("#{bin}/astartectl utils device-id validate 2TBn-jNESuuHamE2Zo1anA").strip
  end
end
