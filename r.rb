class R < Formula
  desc "r is a contextual, path based, bash history."
  homepage "https://jesselucas.github.io/r/"
  url "https://github.com/jesselucas/r/archive/0.4.2.tar.gz"
  version "0.4.2"
  sha256 "8bae9b6f7b81a3a3ed6debdc2308b501b408f6aee06f744b7216105989c0c5aa"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"

    (buildpath/"src/github.com/jesselucas/r/").install Dir["*"]
    system "go", "build", "-o", "#{bin}/r", "github.com/jesselucas/r/cmd/r/"
  end

  def caveats; <<-EOS.undent
    `r` has succesfully installed. Please restart your Bash shell.
    EOS
  end

  test do
    actual = system("r -install")
    expected = true
    actualVersion = pipe_output("#{bin}/r -version")
    assert_block do
      actual == expected
      actualVersion == version
    end
  end
end
