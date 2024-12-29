class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "1.0.11"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.11/jobshell-macos-aarch64"
      sha256 "0df8b766bb70d6a39bdd021f16eef2ac20ec06b60c3df59dc927b34b79012d40"
    else
      url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.11/jobshell-macos-x86_64" 
      sha256 "4a7e1c59100e397decdfb216cc14dee8381b202f8176eab97f1955469088e1df"
    end
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.11/jobshell-linux"
    sha256 "b9e24bbd747f1c3a2877183c9a0d7c48b4f9d15c9af96f19d467ac1aacbdcf07"
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
    assert_match "JobShell v1.0.11", shell_output("\#{bin}/jobshell --version")
  end
end
