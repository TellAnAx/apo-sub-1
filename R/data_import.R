
# Create vector with all files in the data folder
list_of_files <- list.files("data")


# Create empty data frames to hold data
species <- data.frame()
saturation <- data.frame()
mass <- data.frame()


# Load data
for(file in 1:length(list_of_files)) {
  
  if(grepl("species", list_of_files[file]) == TRUE) {
     temp_species <- readWorksheetFromFile(paste0("data/", list_of_files[file]), sheet = "Sheet1", endCol = 3)
     species <- rbind(species, temp_species)
     
  } else if(grepl("saturation", list_of_files[file]) == TRUE) {
    temp_saturation <- readWorksheetFromFile(paste0("data/", list_of_files[file]), sheet = "Sheet1", endCol = 11)
    saturation <- rbind(saturation, temp_saturation)
    
  } else if(grepl("mass", list_of_files[file]) == TRUE) {
    temp_mass <- readWorksheetFromFile(paste0("data/", list_of_files[file]), sheet = "Sheet1", endCol = 7)
    mass <- rbind(mass, temp_mass)
    
  }
  
}

rm(temp_mass, temp_saturation, temp_species)