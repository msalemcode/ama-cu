# AMA-CU

A sample that will allow you to posting events to metered billing in a Managed Application from a VM. The VM is deployed into the managed resource group.

## Installation

1. Use the contents of the `arm` folder to create a ZIP file for your plan in Partner Center, or just use the `app.zip`" file already in the repo.
1. Upload the new ZIP file to the Azure Managed Application plan in Partner Center.
1. Publish the plan.
1. From Preview, purchase the plan.
1. After deployment is complete, remote into the VM.
1. Install git on the VM.
1. Clone this repo to the target VM

## Usage

1. Open the [RunIt](./ps/RunIt.ps1) file and see the arguments you need to pass to the actual script.
1. Provide the correct values for the arguments.
1. In PowerShell, navigate to the `ps` folder.
1. Type `./RunIt/ps1`
1. The results of the call will be show at the bottom of the terminal window after the script runs.
    1. If there is an error - The meter did not get called or the meter is a duplicate of one sent earlier.
    1. If the meter completes it will show the output of the JSON at the bottom of the screen.
