class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "1.0.12"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.12/jobshell-macos-aarch64"
      sha256 "8f5c2f9b443c6cfaf3683e4bfd9277cebf768f3d19eb771d2c206434efb29683"
    else
      url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.12/jobshell-macos-x86_64" 
      sha256 "94845b22631885c999e145945b0b002fc1b635eea89187d0517a147a9908a8e1"
    end
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.12/jobshell-linux"
    sha256 "73edbefd1898c3d36304acdee8ca1bca391b28f3d773d87534a34025b7c4152c"
  end

  def install
    # Rename the binary to 'jobshell' during installation
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "jobshell-macos-aarch64" => "jobshell"
      else
        bin.install "jobshell-macos-x86_64" => "jobshell"
      end
    else
      bin.install "jobshell-linux" => "jobshell"
    end
  end

  test do
    # Ensure the binary runs and displays the expected version
    assert_match "JobShell v1.0.12", shell_output("\#{bin}/jobshell --version")
  end
end
