terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Owner = "Davi Vargas"
      Env   = "Prod"
      Class = "CLC10"
    }
  }
  region     = "us-east-1"
  access_key = "ASIARQXACUPS673KCBE7"
  secret_key = "OO2U4R8C+BptmuWKSLRAwo4TY0eSxtuJiYmxKMfN"
  token      = "FwoGZXIvYXdzEHgaDKORtgeHU8fdXtiN8iLaAUz9Hu9vHnFm6V1ng1mRjp8Z1cESDdh+49PP5KG5FzzuPpki5liJNfZF+NvsQoRcrzEskANCDFolRe1PmZyuAhGiFEayZgnDZdiYk6qsKALSQ1CSnAUHicOvqxymdN0C/5eayUMtVpyZfd9eSWeyiWYHQq39i4NyH+ocDZWfbGSZSoW1BSGY/Re5P8x0HuKREerc7Wvmh4RVpJEKRJdEs2vGRjqSXWbu8HOnROo7Pw0XzVCz80M35+nuVm1AEABM4Ie9ZsSRbdlJxcZSpooaQFV6qTihw4uJl/ezKOiJjqgGMi26FrKZf0h0mhcHFa4Q/JN7QzG4C7Uma67JEJagaiLUbCneSZrFY/GRAc7izH8="

}