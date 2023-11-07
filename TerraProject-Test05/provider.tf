
locals {
  input_file1        = "conf.yaml"
  input_file_content1 = fileexists(local.input_file1) ? file("conf.yaml") : "NoInputFileFound: true"
  raw_settings1 = yamldecode(local.input_file_content1)
  settings1 = {
    inputs = tomap({
      for v in local.raw_settings1.inputs : v.name => v.default
    })
  }
}

provider "aws" {
  region  = local.settings1.inputs.aws_region
}