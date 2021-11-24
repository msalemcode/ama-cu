# AMA-CU

A sample that will allow you to posting events to metered billing in a Managed Application from a VM. The VM is deployed into the managed resource group.

## Installation

1. Use the contents of the `arm` folder to create a ZIP file for your plan in Partner Center, or just use the `app.zip` file already in the repo.
1. Upload the new ZIP file to the Azure Managed Application plan in Partner Center.
1. Publish the plan.
1. From Preview, purchase the plan.
1. After deployment is complete, remote into the newly deployed VM.


## Usage

Perform the following from a remote session to the VM created during install.

1. Options for getting the code:
    1. Install git and clone this repo to the target VM.
    1. Download the code [as a ZIP file](https://github.com/dstarr/ama-cu/archive/refs/heads/main.zip) from GitHub to the target VM.
1. Open the [RunIt](./ps/RunIt.ps1) file and see the arguments you need to pass to the actual script.
1. Provide the correct values for the arguments.
1. In PowerShell, navigate to the `ps` folder.
1. Type `./RunIt/ps1`
1. The results of the call will be show at the bottom of the terminal window after the script runs.
    1. If there is an error - The meter did not get called or the meter is a duplicate of one sent earlier. The error message will indicate which.
    1. Then the meter has been posted successfully it will show the output of the reply JSON at the bottom of the screen.
