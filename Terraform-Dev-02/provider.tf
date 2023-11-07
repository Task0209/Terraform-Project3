provider "aws" {
  region = "ap-southeast-2" 
}

provider "aws" {
  alias  = "US"
  region = "us-east-1"
}
