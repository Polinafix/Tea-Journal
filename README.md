# Tea Journal 

This is an application for tea drinkers, to help them track their personal tea inventory of the teas they have tried or want to try, and make tasting notes on them. There is also a separate tea timer for brewing.


### Features:

-	Keep track of the personal tea inventory.
-   Add new tea with name, brand, type and any picture from your phone library.
-   Search your tea collection by tea name, brand or type.
-   Delete any tea from your collection.
-   Share your tea from the collection with a picture and message to Twitter or Facebook.
-   Detailed view of tea with a larger picture and option to add a tasting note.
-   Tea timer for brewing with alarm.
-   Easy navigation using navigation view and tab view.

## Detailed description with screenshots


##### 1. My Collection Screen

The first time a user opens the application, the empty Table View is shown. To add Tea to the Collection, user needs to click on a “+” button in the navigation panel.

![img1](http://i.imgur.com/hI4L2JU.png)

##### 2. Tea Timer Screen
We use a Tab bar to switch to the timer. 
Using a slider, a user sets up the required brewing time and clicks on the “start” button for the countdown to begin. Once the time is up, the sound alarm goes off. User can click on the “stop” button to cancel the timer at any moment or to stop the alarm.


![img2](http://i.imgur.com/L5EeSF2.png)

##### 3. Add New Tea Screen
By clicking on the picture icon, user can upload pictures from the phone photo library. The application will ask for permission to access the library. Next, the user fills in the information about a tea. Clicking on the Type text field brings up the picker view with predefined tea types to choose from.
If the user has tried the tea, this will be reflected in the previous view and the tea in the collection list will be marked with a tick. If the user does not provide name and brand he will see the alert message when trying to save.

![img3](http://i.imgur.com/m1A1Pe0.png)

##### 4.
That’s what the “My Collection Screen” looks like after tea is added. Each item has a picture, a name and a type. 

![img4](http://i.imgur.com/KZGkvxt.png) 

##### 5. 
 Swiping to the left provides an option to either share the particular tea or delete it from the collection.

![img6](http://i.imgur.com/jDyw3p1.png)
![img7](http://i.imgur.com/QvGNCM7.png)



##### 6. Searching
The user can search the existing tea collection by name, brand or type with an option to navigate from the found item to the detailed view.


![img7](http://i.imgur.com/NrSxgOg.png)

##### 7. Detailed view screen

Clicking on a tea in the collection takes the user to the screen with a larger picture and short description (Name and Brand) and tasting note(if it was created before). 


![img8](http://i.imgur.com/S3F6aht.png)
![img9](http://i.imgur.com/MM2uD0j.png)

##### 8. Add Note Screen
Clicking on the “notepad” icon takes the user to the next screen where he can add the tasting note. Clicking on the “save” button will save the note and display it in the detail view.
Clicking on the “cross” button will close the view.
The content view and the cross button are animated (when the screen appears).


![img9](http://i.imgur.com/tIWZBqF.png)








## API features

###### 1) UIImagePickerController 

Was used to allow users load saved images from the photo library when adding a tea. To load up the photo library, an instance of UIImagePickerController was created and its sourceType was set to. photoLibrary. Used present (_: animated: completion:) method to bring up the photo library. Explicitly described the reason my app wants to access the user's photo library by adding a key (NSPhotoLibraryUsageDescription) in the Info.plist file.
To interact with the image picker interface, our View Controller should adopt two delegates: UIImagePickerControllerDelegate and UINavigationControllerDelegate. When a user chooses a photo from the photo library, the imagePickerController (_: didFinishPickingMediaWithInfo:) method of the delegate is called to get the selected photo from the method's parameter.
###### 2) NSLayoutConstraint 
Was used to fix the issues, connected with satisfying the constraints and centring the image in the cell. Added a few layout constraints programmatically to make the image is bound within the viewable area.
###### 3)	UITapGestureRecognizer
Was used to assign an action to UIImageView, to bring up the photo library when the user clicks on the picture icon.
###### 4)UISearchController
User can search their tea collection by name, brand and type using a search bar and manage search results. First, I created a new array variable to store the search results and then used a built-in method called filter to loop over a collection of items and return a new array containing those items that match the
specified condition for filtering. To update and display the search
results on screen, UISearchResultsUpdating protocol was adopted. Then, when a user selects the search bar, the method updateSearchResults (for:) is called.
###### 5)UIView animation
The structure CGAffineTransform was used to scale down the view which is presented when the user wants to add a note (when it is first loaded). To create the growing effect, the method UIView. animate (withDuration: animations:) was used to animate the size change.
Spring animation was used to animate a “cross” button to create a move-in effect from right to left.
###### 6)UIActivityViewController
 When a user swipes a tea in the collection to the left, they can tap on the “share” button, which will bring up an activity controller for social sharing. The UIActivityViewController class is used here to provide a service of sharing content to social media websites. 


###### 7)Navigation Controller
Was used to display hierarchical content. For example, Table View with a tea collection and a Detailed View screen. I also utilised an appearance proxy to customize the visual appearance of the Navigation Bar, such as background and tint colour. To apply the customization to the entire application I put the code in the AppDelegate class. To hide the bars on swipe, I used the hidesBarsOnSwipe property.
###### 8)Self-Sizing Cells in UITableView
This feature was used to allow displaying dynamic content in a table view with multiple rows.
###### 9)Tab bar
Was used to create easy navigation between Tea Collection screen and Timer screen. The Appearance API was utilized to customize its appearance.
###### 10)AVFoundation: AVAudioPlayer
Was used to play the sound alarm when the tea timer goes off.
###### 11)Timer
Was used to implement countdown for the tea timer.
###### 12)UIPickerView
When adding a tea to a collection, a user can choose the time from the predefined options in the pickerView, which appears at the bottom of the screen once a user touched the Type text field. This was implemented by setting the inputView of the textField to pickerView.
###### 13)Core Data Framework
Was used to save the tea and notes permanently. First, I Created the Data Model for the Tea object, added necessary attributes, then created Managed Objects. Used NSPersistentContainer to implement inserting a record to database. Used NSFetchedResultsController API to manage the results returned from a Core Data fetch request, and provide data for a table view.


## Acknowledgments
Tutorials that I used:
- Beginning iOS 10 Programming with Swift 3 - AppCoda





  





