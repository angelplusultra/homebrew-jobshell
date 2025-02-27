#!/bin/bash

# Check if version argument is provided
if [ -z "$1" ]; then
    echo "Please provide a version number"
    exit 1
fi

version="$1"

# Define URLs
arm_url="https://github.com/angelplusultra/job-shell/releases/download/v${version}/jobshell-macos-aarch64"
intel_url="https://github.com/angelplusultra/job-shell/releases/download/v${version}/jobshell-macos-x86_64"
linux_url="https://github.com/angelplusultra/job-shell/releases/download/v${version}/jobshell-linux"

# Create temporary directory for downloads
temp_dir=$(mktemp -d)
cd "$temp_dir" || exit 1

# Download binaries using curl with output redirection
echo "Downloading jobshell binaries..."

if ! curl -sL "$arm_url" > jobshell_arm; then
    echo "Failed to download ARM binary"
    exit 1
fi

if ! curl -sL "$intel_url" > jobshell_intel; then
    echo "Failed to download Intel binary"
    exit 1
fi

if ! curl -sL "$linux_url" > jobshell_linux; then
    echo "Failed to download Linux binary"
    exit 1
fi

echo "Download completed successfully"

# Calculate SHA256 checksums
echo "Calculating sha256 checksums..."
arm_sha256=$(shasum -a 256 jobshell_arm | cut -d' ' -f1)
intel_sha256=$(shasum -a 256 jobshell_intel | cut -d' ' -f1)
linux_sha256=$(shasum -a 256 jobshell_linux | cut -d' ' -f1)

if [ -z "$arm_sha256" ] || [ -z "$intel_sha256" ] || [ -z "$linux_sha256" ]; then
    echo "Failed to calculate sha256 checksums"
    cd - > /dev/null || exit 1
    rm -rf "$temp_dir"
    exit 1
fi

# Create Formula directory if it doesn't exist
cd - > /dev/null || exit 1
mkdir -p Formula

echo "Creating formula file..."

# Create the formula file
cat > "./Formula/jobshell.rb" << EOL
class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers by scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "${version}"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/angelplusultra/job-shell/releases/download/v${version}/jobshell-macos-aarch64"
      sha256 "${arm_sha256}"
    else
      url "https://github.com/angelplusultra/job-shell/releases/download/v${version}/jobshell-macos-x86_64" 
      sha256 "${intel_sha256}"
    end
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v${version}/jobshell-linux"
    sha256 "${linux_sha256}"
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
    assert_match "JobShell v${version}", shell_output("\#{bin}/jobshell --version")
  end
end
EOL

# Clean up
rm -rf "$temp_dir"

echo "Formula file created successfully at ./Formula/jobshell.rb"
