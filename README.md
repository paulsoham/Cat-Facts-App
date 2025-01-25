#  Cat Facts App

##  Overview
Cat Facts is an iOS application developed using UIKit that provides users with random cat facts and images. The app fetches cat facts from the MeowFacts API and cat images from TheCatAPI. It displays a cat fact and a corresponding cat image, allowing users to refresh the content by tapping anywhere on the screen.
##  Requirements
	•	iOS 18.0 or later
	•	Xcode 16.0 or later
	•	UIKit

##  Screenshots
<table> <tr> <td>Cat Facts</td> <td>Cat Facts</td> </tr> <tr> <td><img src="https://github.com/paulsoham/Assets/blob/master/1.png" width=100% height=100%></td> <td><img src="https://github.com/paulsoham/Assets/blob/master/2.png" width=100% height=100%></td> </tr> </table>

##  Usage
	•	Launch the app to view a random cat fact and image.
	•	Tap anywhere on the screen to refresh the content with new cat facts and images.

##  Localization
The app supports localization for various strings to enhance user experience. All localizable strings are stored in the Localizable.strings file.
##  Features
	•	Fetch Cat Facts: Retrieve random cat facts from the MeowFacts API.
	•	Fetch Cat Images: Retrieve random cat images from TheCatAPI.
	•	User-Friendly Interface: Simple and intuitive design using UIKit.
	•	Refresh Content: Tap anywhere on the screen to load new cat facts and images.

##  Technologies
	•	UIKit: For building the user interface.
	•	Async-Await: For asynchronous data fetching.
	•	Custom API Service: For fetching data from external APIs.

##  Architecture
The application follows the MVVM (Model-View-ViewModel) architecture pattern to separate concerns and enhance testability.

##  Data Models
The main data models are CatFact and CatImage, which are represented as Codable structs:
	•	CatFact: Represents a cat fact retrieved from the MeowFacts API.
	•	CatImage: Represents a cat image URL retrieved from TheCatAPI.

##  API Service
The APIService class is responsible for fetching data from the MeowFacts API and TheCatAPI. It handles network requests and decodes the data into the appropriate models.

##  Image Service
The ImageService class handles the downloading of images from the URL provided by TheCatAPI. It uses the APIService to fetch image data and convert it into a UIImage.

##  ViewModel
The CatViewModel class is responsible for managing the data for the view. It fetches the cat fact and cat image asynchronously and updates the UI accordingly.

##  ViewController
The CatViewController class displays the cat fact and cat image to the user. It also allows the user to refresh the content by tapping anywhere on the screen.
##  Error Handling
The app implements error handling for network requests and image downloads, ensuring that users are informed of any issues encountered.

##  Unit Testing
The application includes unit tests written using XCTest. Tests cover:
	•	Validating the fetching of cat facts and images.
	•	Ensuring error handling works as expected.

##  Installation
Clone the Repository
git clone https://github.com/paulsoham/CatFactsApp.git

##  License
This project is licensed under the MIT License - see the LICENSE file for details.

##  Author
* Soham Paul - https://github.com/paulsoham
