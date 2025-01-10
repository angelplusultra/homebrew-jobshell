class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "2.0.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.1/jobshell-macos-aarch64"
      sha256 "6f15102a8c4cf4f60a3b2c5151855fd64273fbca2b5f93e4be4c449b695d1998"
    else
      url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.1/jobshell-macos-x86_64" 
      sha256 "5f9462ae1d72d39a6818014c1bdc4da56fcf644fb9f281455a89cef6ff46d71d"
    end
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.1/jobshell-linux"
    sha256 "aeea41ef7ebfcd731089bc25396bc010bb86c84cee02bdbf8bf9cfecb35c49a4"
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
    assert_match "JobShell v2.0.1", shell_output("\#{bin}/jobshell --version")
  end
end
