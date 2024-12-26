class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "1.0.8"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.8/jobshell-macos-aarch64"
    sha256 "ab9431276f60d84808cb31099fd4c1b409bb8ded1cb1d1ed042048cc6afbbece"
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.8/jobshell-macos-x86_64"
    sha256 "0cf9343da74806057814d3deaaaa29e5da4ed7b3490b9c4e76edbf2c78c71259"
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
    assert_match "JobShell v1.0.8", shell_output("\#{bin}/jobshell --version")
  end
end
