class R < Formula
  desc "r is a contextual, path based, bash history."
  homepage "https://jesselucas.github.io/r/"
  url "https://github.com/jesselucas/r/archive/0.4.0.tar.gz"
  version "0.4.0"
  sha256 "b82476b4c7b64ab789f4918ab64a6766ae4be06b5553792a2ed0c1342ad7e442"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"

    (buildpath/"src/github.com/jesselucas/r/cmd/r").install Dir["*"]
    system "go", "build", "-o", "#{bin}/r/cmd/r", "-v", "github.com/jesselucas/r/cmd/r"
  end

  def caveats; <<-EOS.undent
    `r` has succesfully installed. Please restart your Bash shell.
    EOS
  end

  test do
    actual = system("r -install")
    expected = true
    actualVersion = pipe_output("#{bin}/r/cmr/r -version")
    assert_block do
      actual == expected
      actualVersion == version
    end
  end
end
