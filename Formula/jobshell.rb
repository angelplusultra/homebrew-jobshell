class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "2.0.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.2/jobshell-macos-aarch64"
      sha256 "3b3c625737d8cfb326985032b427d6fb5170a6c247ea0a7977a222bb68de8c34"
    else
      url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.2/jobshell-macos-x86_64" 
      sha256 "d46df616d46f0776c337b3240372c267262342c021be587162b33c4c22410024"
    end
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.2/jobshell-linux"
    sha256 "57f48a234780fb7b3968f08d03335dd6c1950bdacce6d6b658bafb7c84d56fee"
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
    assert_match "JobShell v2.0.2", shell_output("\#{bin}/jobshell --version")
  end
end
