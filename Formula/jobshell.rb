class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "2.0.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.0/jobshell-macos-aarch64"
      sha256 "5588087805f92b8c09ab9f4aa7a98a8e51744b1b5dc1c09a72b560a09371bb8f"
    else
      url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.0/jobshell-macos-x86_64" 
      sha256 "985fa5a8c1f068ec2c5052f114ea3a4906f733b2ee0f1fb497bc9cb889898a18"
    end
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.0/jobshell-linux"
    sha256 "9a543a78d14fdff73df6f40087abaafe39f5175b97917f063ddcfa6dcecb5e68"
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
    assert_match "JobShell v2.0.0", shell_output("\#{bin}/jobshell --version")
  end
end
