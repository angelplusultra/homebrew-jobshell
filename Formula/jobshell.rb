class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "2.0.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.0/jobshell-macos-aarch64"
      sha256 "274a9938080c876cd18f817e02073d12ba87f2927984b247126c039100c7d619"
    else
      url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.0/jobshell-macos-x86_64" 
      sha256 "750519392c01d3428e7c89bb89cdc32b40d0e33a1ded05c4478f40a10209dece"
    end
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v2.0.0/jobshell-linux"
    sha256 "aed8acf47bf9a0de13db76507fdbd5c989cb43b2f54a3d377fc0dbc95810ce96"
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
