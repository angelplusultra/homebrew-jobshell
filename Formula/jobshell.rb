# class Jobshell < Formula
#   desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
#   homepage "https://github.com/angelplusultra/job-shell"
#   version "1.0.5"
#   license "MIT"
#
#   if Hardware::CPU.arm?
#     url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.5/jobshell-macos-aarch64"
#     sha256 "57ef620a5073e6341990a815e52c5f3d86c0efa39a405459a4aa48254ae30876"
#   else
#     url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.5/jobshell-macos-x86_64"
#     sha256 "a08b3427c8ef783bc016b7c91bb7ee3e86ae6a8f8e5406ff50e8ef5553ab0961"
#   end
#
#   def install
#     bin.install "jobshell"
#   end
#
#   test do
#     assert_match "JobShell v1.0.5", shell_output("#{bin}/jobshell --version")
#   end
# end

class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "1.0.5"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.5/jobshell-macos-aarch64"
    sha256 "57ef620a5073e6341990a815e52c5f3d86c0efa39a405459a4aa48254ae30876"
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v1.0.5/jobshell-macos-x86_64"
    sha256 "a08b3427c8ef783bc016b7c91bb7ee3e86ae6a8f8e5406ff50e8ef5553ab0961"
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
    assert_match "JobShell v1.0.5", shell_output("#{bin}/jobshell --version")
  end
end
