class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "1.0.7"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.7/jobshell-macos-aarch64"
    sha256 "8fa061faecd4ecce7ca42dd58afbeb1ad23e7934fa61d45479f033b03be6c222"
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.7/jobshell-macos-x86_64"
    sha256 "9b9fc9d35c6fb62d4073bcc249f309a886c1e84eee4fba595a8b5f52af0e7cb6"
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
    assert_match "JobShell v1.0.7", shell_output("\#{bin}/jobshell --version")
  end
end
