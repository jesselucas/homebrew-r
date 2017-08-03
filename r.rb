class R < Formula
  desc "r is a contextual, path based, bash history."
  homepage "https://jesselucas.github.io/r/"
  url "https://github.com/jesselucas/r/archive/0.4.3.tar.gz"
  version "0.4.3"
  sha256 "914099bda3b30090437251057ab13ec5e4bed0d6f3fe44739e054d136385f826"

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
