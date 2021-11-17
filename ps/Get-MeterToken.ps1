$cAccessToken = Get-ClientAccessToken

Write-Host "cAccessToken " $cAccessToken

#---------------------------------------------------------------------
# FUNCTIONS BELOW
#---------------------------------------------------------------------

function Get-ClientAccessToken() {
    
    $issuerUrl = $env:MSI_ENDPOINT
    $secret = $env:MSI_ENDPOINT

    $resourceURI = "https://management.azure.com/"
    $uri = $issuerUrl + "?resource=$resourceURI&api-version=2017-09-01"

    $headers = @{
        'Secret' = $secret
        'Content-Type'  = 'application/json'
    }
    
    $response = Invoke-RestMethod -Method Get -Headers $headers -Uri $uri
    
    return $response.access_token
}

function Invoke-MeterEvent() {

    

    $uri = "https://marketplaceapi.microsoft.com/api/usageEvent?api-version=2018-08-31"

    $headers = @{
        'Authorization' = 'Bearer ' + $accessToken
        'Content-Type'  = 'application/json'
    }

    # FINISH THIS
}