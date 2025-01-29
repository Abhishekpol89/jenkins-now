terraform { 
  cloud { 
    
    organization = "terraform-abhishek" 

    workspaces { 
      name = "dev-terraformstatefile" 
    } 
  } 
}