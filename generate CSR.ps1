# Generate a Certificate Signing Request (CSR) with custom configurations

# Define the subject information
$subject = @{
    Country       = "US"                    # Country/Region Code (e.g., US)
    State         = "New York"              # State or Province Name
    City          = "New York City"         # Locality Name (e.g., city)
    Company       = "Example Corp"          # Organization Name (e.g., company)
    Unit          = "IT"                    # Organizational Unit Name (e.g., department)
    CommonName    = "www.example.com"       # Common Name (e.g., domain name)
}

# Define the Subject Alternative Names (SANs)
$sans = @("example.com", "www.example.com", "subdomain.example.com")

# Define the export path for the CSR
$exportPath = "C:\path\to\export\csr.csr"   # Specify the desired export path and filename

# Define the CSP name and key algorithm
$cspName = "Microsoft RSA SChannel Cryptographic Provider"
$keyAlgorithm = "RSA"

# Define additional CSR options
$csrOptions = @{
    KeyType               = "Exchange"      # Key type (Exchange or Signature)
    KeyUsage              = "KeyEncipherment" # Key usage
    RequestFormat         = "PKCS10"        # Request format (PKCS10 or PKCS7)
    CertRequest           = $true           # Generate CSR
    ProviderName          = $cspName        # Cryptographic Service Provider (CSP) name
    KeyLength             = 2048            # Key length
    SAN                   = $sans           # Subject Alternative Names (SANs)
    NotBefore             = (Get-Date)      # Validity period start
    NotAfter              = (Get-Date).AddYears(1) # Validity period end (1 year from now)
    Exportable            = $true           # Allow private key export
    KeySpec               = 1               # Key specification (1 = Exchange, 2 = Signature)
    KeyExportPolicy       = 1               # Key export policy (1 = Allow export)
    KeyProtection         = 1               # Key protection (1 = No protection)
    UseLegacyKey          = $true           # Use legacy key (no template)
}

# Generate the CSR
$csr = New-SelfSignedCertificate @csrOptions

# Export the CSR to a file in Base64 format
$exportOptions = @{
    FilePath = $exportPath
    Encoding = [System.Text.Encoding]::ASCII
}

$exportedCsr = $csr.Export('Request', $exportOptions)

Write-Host "Certificate Signing Request (CSR) generated and exported to: $exportPath"
