class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "2.0.3"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.3/jobshell-macos-aarch64"
      sha256 "fc3afa2bb93ee23378596926adb48351c5667a2fe2a9f2c1a1388fb5a566e40b"
    else
      url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.3/jobshell-macos-x86_64" 
      sha256 "baeff5783b4a94209b585bb878f8ffd7c2a05d1a0cc2bb321aeba1f420b3c8ba"
    end
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.3/jobshell-linux"
    sha256 "a69aa691cef0070b9acb8470f5f89f6eb80c933d3d5cab1d942fa7eaa09444d0"
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
    assert_match "JobShell v2.0.3", shell_output("\#{bin}/jobshell --version")
  end
end
