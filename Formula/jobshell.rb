class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "1.0.10"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.10/jobshell-macos-aarch64"
    sha256 "090e9bcb61abc532eb6e99d78a2b03e18063a97aaedfcdc693bab1665c8361a7"
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.10/jobshell-macos-x86_64"
    sha256 "9f62810c442a02edcf0acd127c8d0249aae94f7fd563ab8b58c7ce0d849b5b02"
  end

  def install
    # Rename the binary to `jobshell` during installation
    if Hardware::CPU.arm?
      bin.install "jobshell-macos-aarch64" => "jobshell"
    else
      bin.install "jobshell-macos-x86_64" => "jobshell"
    end
  end

  test do
    # Ensure the binary runs and displays the expected version
    assert_match "JobShell v1.0.10", shell_output("\#{bin}/jobshell --version")
  end
end
