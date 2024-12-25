

const { execSync } = require('child_process');
const fs = require('fs');



const version = process.argv[2];

if (!version) {
	console.error('Please provide a version number');
	process.exit(1);
}


const armUrl = `https://github.com/angelplusultra/job-shell/releases/download/v${version}/jobshell-macos-aarch64`
const intelUrl = `https://github.com/angelplusultra/job-shell/releases/download/v${version}/jobshell-macos-x86_64`;



// Download the binary using curl
try {
	console.log('Downloading jobshell binary...');
	execSync(`curl -L -o jobshell_arm ${armUrl}`, {
		stdio: 'inherit'
	});

	execSync(`curl -L -o jobshell_intel ${intelUrl}`, { stdio: 'inherit' });

	console.log('Download completed successfully');
} catch (error) {
	console.error('Failed to download binary:', error.message);
	process.exit(1);
}



// Get the sha256 checksum of the binary
//

let armsha256 = '';
let intelsha256 = '';
try {
	console.log('Calculating sha256 checksum...');
	armsha256 = execSync('shasum -a 256 jobshell_arm').toString().split(' ')[0];
	intelsha256 = execSync('shasum -a 256 jobshell_intel').toString().split(' ')[0];
} catch (error) {
	console.error('Failed to calculate sha256 checksum:', error.message);
	process.exit(1);
}



let formula = `
class Jobshell < Formula
  desc "Command-line tool that simplifies job searching for software engineers b
y scraping job postings from companies you care about"
  homepage "https://github.com/angelplusultra/job-shell"
  version "${version}"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/angelplusultra/job-shell/releases/download/v${version}/jobshell-macos-aarch64"
    sha256 "${armsha256}"
  else
    url "https://github.com/angelplusultra/job-shell/releases/download/v${version}/jobshell-macos-x86_64"
    sha256 "${intelsha256}"
  end

  def install
    # Rename the binary to \`jobshell\` during installation
    if Hardware::CPU.arm?
      bin.install "jobshell-macos-aarch64" => "jobshell"
    else
      bin.install "jobshell-macos-x86_64" => "jobshell"
    end
  end

  test do
    # Ensure the binary runs and displays the expected version
    assert_match "JobShell v${version}", shell_output("#{bin}/jobshell --version")
  end
end
`


	
fs.writeFileSync("./Formula/jobshell.rb", formula);
