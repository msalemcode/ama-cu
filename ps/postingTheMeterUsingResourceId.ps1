$ErrorActionPreference = "Stop"

function Invoke-Meter() {

    Param (
        [Parameter(Mandatory)]
        [string]
        $DimensionName,

        [Parameter(Mandatory)]
        [string]
        $PlanId,

        [Parameter(Mandatory)]
        [string]
        $Quantity
    )

    # Get system identity access token
    # You will use this token for calling the management API
    $ManagementTokenUrl = "http://169.254.169.254/Metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F"
    $Token = Invoke-RestMethod -Headers @{"Metadata" = "true" } -Uri $ManagementTokenUrl 

    # Get subscription and resource group
    $MetadataUrl = "http://169.254.169.254/Metadata/instance?api-version=2019-06-01"
    $Metadata = Invoke-RestMethod -Headers @{'Metadata' = 'true' } -Uri $MetadataUrl

    # Make sure the system identity has at least reader permission on the resource group through the deployment template
    $Headers = @{
        "Authorization" = "$($Token.token_type) $($Token.access_token)"
        "Metadata"      = "true"
    }
    $ManagementUrl = "https://management.azure.com/subscriptions/" + $Metadata.compute.subscriptionId + "/resourceGroups/" + $Metadata.compute.resourceGroupName + "?api-version=2019-10-01"
    $ResourceGroupInfo = Invoke-RestMethod -Headers $Headers -Uri $ManagementUrl 
    $ManagedAppId = $ResourceGroupInfo.managedBy

    # Get ResourceUsageId from the managed app
    # A nested deployment within the template is used to give read access to the managed identity.
    $ManagedAppUrl = "https://management.azure.com" + $ManagedAppId + "\?api-version=2019-07-01"
    $ManagedApp = Invoke-RestMethod -Headers $Headers -Uri $ManagedAppUrl  
    $ResourceUsageId = $ManagedApp.properties.billingDetails.ResourceUsageId

    # Get the token for calling the metering API
    $MeteringApiTokenUrl = "http://169.254.169.254/Metadata/identity/oauth2/token?api-version=2018-02-01&resource=20e940b3-4c77-4b0b-9a53-9e16a1b010a7"
    $Token = Invoke-RestMethod -Headers @{"Metadata" = "true" } -Uri $MeteringApiTokenUrl 

    # Set to use TLS 1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12;

    $startTime = (Get-Date).AddMinutes(-60).ToString("yyyy-MM-ddTHH:mm:ssZ")

    $Headers = @{
        "Authorization" = "$($Token.token_type) $($Token.access_token)"
    }

    $Body = @{ 
        "resourceId"         = $ResourceUsageId
        "quantity"           = $Quantity 
        "dimension"          = $DimensionName
        "effectiveStartTime" = $startTime
        "planId"             = $PlanId
    } | ConvertTo-Json

    # Post the meter
    $Response = Invoke-RestMethod 'https://marketplaceapi.microsoft.com/api/usageEvent?api-version=2018-08-31' -Method 'POST' -ContentType "application/json" -Headers $Headers -Body $Body -Verbose

    Write-Host "-----------------------------------------------"
    Write-Host ($Response | ConvertTo-Json)
    Write-Host "-----------------------------------------------"

}
