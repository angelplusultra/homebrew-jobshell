class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "1.0.4"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.4/jobshell-macos-aarch64-binary.zip"
    sha256 "c20241e9ff5de97617e2e2527cba253f0987e192b1585089967d64b1ed6faa8"
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.4/jobshell-macos-x86_64-binary.zip"
    sha256 "28122f310fb4bb10c55a4e0e0302e64f6b81bfa604be2725653b2d7121aaa5c8"
  end

  def install
    bin.install "jobshell"
  end

  test do
    assert_match "JobShell v1.0.4", shell_output("#{bin}/jobshell --version")
  end
end
