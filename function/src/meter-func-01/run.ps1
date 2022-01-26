using namespace System.Net

# $ErrorActionPreference = "Stop"

param($Request, $TriggerMetadata)

Write-Host "FOO"

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

$DimensionId = $Request.Body.Dimension
$PlanId = $Request.Body.PlanId
$Quantity = $Request.Body.Quantity
$EffectiveStartTime = $Request.Body.EffectiveStartTime

$IdentityEndpoint = $Env:IDENTITY_ENDPOINT
$IdentityHeader = $Env:IDENTITY_HEADER
$ResouceGroupName = $Env:WEBSITE_RESOURCE_GROUP

$resourceURI = "https://management.azure.com/"
$tokenAuthURI = $IdentityEndpoint + "?resource=$resourceURI&api-version=2019-08-01"
$tokenResponse = Invoke-RestMethod -Method Get -Headers @{"X-IDENTITY-HEADER" = "$IdentityHeader" } -Uri $tokenAuthURI


# make the call to the metering API
$headers = @{
    "Authorization" = $tokenResponse.token_type + ' ' + $tokenResponse.token
}

$body = @{
    "quantity" = $Quantity
    "dimension" = $DimensionId
    "effectiveStartTime" = $EffectiveStartTime
    "planId" = $PlanId
}

# $meterCallResponse = Invoke-RestMethod 'https://marketplaceapi.microsoft.com/api/usageEvent?api-version=2018-08-31' -Method 'POST' -ContentType "application/json" -Headers $headers -Body $body -Verbose

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = ($body | ConvertTo-Json)
})