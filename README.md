# PhoneBook
iOS application to store contact details with privacy

I have created phone book application where user can be able to

Sign up with unique user name and password, 
Sign in with user name and password

On successful login, user can be able to save contact details like given name , family name and phone number.
For sign up process , I've added certain conditions like user name must be unique for each user i.e. same user name cannot be used by another user. While sign up, new user must have to enter user name and password i.e. he/she cannot keep it blank. If user meets any one of the above conditions then pop up appears with warning message.

When user successfully signed in on the app, he/she can be able to Create new contact by clicking on Add contact details button. When user creates contact it appears on table view i.e. Retrieves details from Core Data. For Update the contact details, user needs click on particular contact. For Delete the contact, user need to long press on particular contact. Table view data reloads accordingly after any of the CRUD operation performed.

I've stored the user name, password, token (which will be unique ID for data belongs to the user) into keychainStore and contact details data into Core data model. I also used NSPredicate and NSSortDescriptor while fetching the data from CoreData
