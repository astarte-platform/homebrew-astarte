class Astartectl < Formula
  desc "Astarte command-line client utility"
  homepage "https://astarte.cloud"
  url "https://github.com/astarte-platform/astartectl/archive/refs/tags/v22.11.00.tar.gz"
  sha256 "4e5eaf5c4215424d3bf420f601d426cdb0c2b069ae46f248aefe56dfa9440640"

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
