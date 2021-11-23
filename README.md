# AMA-CU

A sample that will allow you to post events to metered billing in a Managed Application from a VM. The VM is deployed into the managed resource group.

## Installation and usage

1. Use the contents of the "arm" folder to create a ZIP file for your plan in Partner Center, or just use the "app.zip" file already there.
1. Upload the new ZIP fle to the plan.
1. Publish the plan.
1. From Preview, purchase the plan.
1. After deployment is complete, remote into the VM.
1. Install git on the VM
1. Clone this repo to the target VM
1. Open the "RunIt.ps1" file and see the arguments you need to pass to the actual script.
1. Provide the correct values for the arguments.
1. In PowerShell, navigate to the "ps" folder.
1. Type `.\RunIt/ps1`
1. The results of the call will be show at the bottom of the terminal window after the script runs.
