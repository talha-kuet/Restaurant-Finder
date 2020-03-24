# Restaurant Finder

Help users to find restarants near to their current location.

## Features

- Get the location of 50 restaurents with 3km of user's current location in a Map
- Can also search for a restaurant with keyword.
- Get some other info like Type when searching for a restaurant

## Requirements

- iOS 13.0+
- Swift 5.0

## Build

First, run the following command in Terminal:

```
git clone <#Project Url#>
```

Second, Install Cocoapods into project:

```
pod install
```

Then, Build and Run the project

## Project Architecture

- Use MVC design pattern mostly to meet deadline
- Also use Singleton for Network call. And use MVVM for showing Restaurant's inforamtion.

## Frameworks

- 'GoogleMaps'
- 'FoursquareAPIClient'
- 'SDWebImage', '~> 5.0'

## Project Tree
* README.md
* Restaurant Finder
  * Controllers
    * MapViewController.swift
    * ResultViewController.swift
    * BaseViewController.swift
  * Views
    * Storyboards
      * Main.storyboard
      * LaunchScreen.storyboard
    * MarkerInfoView.swift
    * PlaceMarker.swift
    * ResultCell.swift
    * ResultCell.xib
  * Model
    * Response.swift
    * SearchResponse.swift
    * Location.swift
    * Venue.swift
    * VenueCategory.swift
    * VenueCategoryIcon.swift
  * Viewmodel
    * ResultCellViewModel.swift
  * Utility
    * Constants.swift
    * APIService.swift
  * Extensions
    * Uiview+Extensions.swift
    * UiSearchBar+Extensions.swift
  * Support Files
    * Info.plist
    * Assets.xcassets
  * AppDelegate.swift
  * SceneDeelgate.swift
* Restaurant FinderTests
* Restaurant FinderUITests
* Products
* Pods
* Frameworks

## Limitations
- Pods are uploaded to remote repository.
- Unit Test code not added
- Project is build mostly on MVC which is more challenging for Unit Testing

## Future Update

- Convert the whole project to MVVM architecture pattern
- Show direction from current location to Restaurant
- Show more details informations about restaurants


