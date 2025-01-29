terraform { 
  cloud { 
    
    organization = "terraform-abhishek" 

    workspaces { 
      name = "prod_statefile_tera" 
    } 
  } 
}