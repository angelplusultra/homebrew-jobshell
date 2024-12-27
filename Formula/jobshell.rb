class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "1.0.9"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.9/jobshell-macos-aarch64"
    sha256 "2a30619627c8a0a8b098b6dd5662dcf7066389911030a3480af70025e54bff4a"
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.9/jobshell-macos-x86_64"
    sha256 "5c62e3769fc36000647b8f646d0e49e7602c0cdd5a91ee5378ea8cccbe5e3505"
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
    assert_match "JobShell v1.0.9", shell_output("\#{bin}/jobshell --version")
  end
end
