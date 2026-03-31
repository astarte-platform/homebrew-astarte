class Astartectl < Formula
  desc "Astarte command-line client utility"
  homepage "https://astarte.cloud"
  url "https://github.com/astarte-platform/astartectl/archive/refs/tags/v24.5.3.tar.gz"
  sha256 "c34a66600362f87efbd5d074dff0214a5cb723e409ba4de967c703a7f9efebd5"

  bottle do
    root_url "https://ghcr.io/v2/astarte-platform/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3c572bedf678caa6ab3ea3021266bd754ea99bc0b54721ebd23d3ecdcf50b9a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c6d3695d6994e5041b07522770f955950489aed81d49f37e36d044fda314bf4a"
  end

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
