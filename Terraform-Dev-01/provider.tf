# Virginia
provider "aws" {
  region = "us-east-1"
}

# Sydney
provider "aws" {
  alias  = "secondary"
  region = "ap-southeast-2"
}

# canada
provider "aws" {
  alias  = "tertiary"
  region = "ca-central-1"
  skip_region_validation = true
}