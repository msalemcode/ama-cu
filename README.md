# Post a Metered Billing Event From an Azure Managed App

A sample that will allow you to posting events to metered billing API in a Managed Application from a VM. The VM is deployed into the managed resource group.

## Installation

1. Use the contents of the `/vm/arm` folder to create a ZIP file for your plan in Partner Center, or just use the `app.zip` file already in the repo.
1. Upload the new ZIP file to the Azure Managed Application plan in Partner Center.
1. Publish the plan. It will take some time for the plan to reach Preview stage.
1. From Preview, purchase the plan.
1. After deployment is complete, remote into the newly deployed VM.

## Usage from the Managed Application

Perform the following from a remote session to the VM created during install. You will execute the commands from inside the VM.

1. Options for getting the code:
    1. Install git and clone this repo to the target VM.
    1. Download the code [as a ZIP file](https://github.com/dstarr/ama-cu/archive/refs/heads/arm.zip) from GitHub to the VM.
1. Open the [RunIt](./vm/ps/RunIt.ps1) file and see the arguments you need to pass to the Invoke-Meter function.
1. Provide the correct values for the arguments.
1. In PowerShell, navigate to the `/vm/ps` folder.
1. Type `./RunIt.ps1`
1. The results of the call will be show at the bottom of the terminal window after the script runs.
    1. If there is an error - The meter did not get called or the meter is a duplicate of one sent earlier. The error message will indicate which.
    1. When the meter has been posted successfully it will show the output of the reply JSON at the bottom of the screen.
