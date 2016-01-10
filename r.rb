class R < Formula
  desc "r is a contextual, path based, bash history."
  homepage "https://jesselucas.github.io/r/"
  url "https://github.com/jesselucas/r/archive/0.4.1.tar.gz"
  version "0.4.1"
  sha256 "24e4bab2a88e59c68f6c027aa1c7e5f272bb695e4102dc1c9e1a2c1acabbc904"

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
