## Secret Santa
## Jon Skaggs
## 2020-10-12


library(mailR)


# vars --------------------------------------------------------------------


myaddress <- "YOUREMAIL@gmail.com"
mypassword <- "YOURPASSWORD"


# read survey -------------------------------------------------------------


santas <- read.csv("./santa_survey.csv", stringsAsFactors = FALSE)


# run ---------------------------------------------------------------------


# Get santas and their emails
rs <- list(santas$name, santas$email)
drop <- c()

# Loop over all santas
for(r in 1:length(rs[[1]])){
  # Get potential giftees
  giftees <- setdiff(rs[[1]], c(drop, rs[[1]][[r]]))
  # Select one giftee randomly
  giftee <- sample(giftees, 1)
  
  body <- paste0("Hi ", rs[[1]][[r]],",",
                 "\n",
                 "Your secret santa is ", giftee, ". Here's all the information we have about them:",
                 "\n",
                 "\n", names(santas)[1], ": ", santas[santas$name == giftee, 1],
                 "\n", names(santas)[2], ": ", santas[santas$name == giftee, 2],
                 "\n", names(santas)[3], ": ", santas[santas$name == giftee, 3],
                 "\n", names(santas)[4], ": ", santas[santas$name == giftee, 4],
                 "\n", names(santas)[5], ": ", santas[santas$name == giftee, 5],
                 "\n", names(santas)[6], ": ", santas[santas$name == giftee, 6],
                 "\n",
                 "\n,
                 "Merry Christmas!")
  
  mailR::send.mail(from = myaddress,
                   to = rs[[2]][[r]],
                   subject = "Your Secret Santa 2020!",
                   body = body,
                   smtp = list(host.name = "smtp.gmail.com", port = 465, 
                               user.name = myaddress,            
                               passwd = mypassword, ssl = TRUE),
                   authenticate = TRUE,
                   send = TRUE)
  drop <- c(drop, giftee)
}
