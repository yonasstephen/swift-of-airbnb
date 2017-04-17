
<img src="http://i.imgur.com/r93YIiC.jpg" width="873">

# Swift of Airbnb

This is a self-taught project of learning Swift inspired by [Sam Lu's 100 Days of Swift] and [Allen Wong's 30 Days of Swift]. Trying to take the learning progress further by making some of Airbnb's screens, which in my opinion is one of the most beautifully-designed iOS App. Kudos to Airbnb for setting such high standard in iOS Development.

# Projects

### Project 1 - Occupant Filter

![occupant-filter](https://media.giphy.com/media/l4FGlDyEy1qJu8Fyw/giphy.gif)

Things I learn:
  - Custom counter control AirbnbCounter
  - Custom UISwitch control AirbnbSwitch which is basically an image UIButton that animates from left to right when the value toggled

### Project 2 - Date Picker

![datepicker](https://media.giphy.com/media/3ohzdZ283FnZaCVG12/giphy.gif)

Things I learn:
  - All kinds of things with UICollectionView (didSelect, didHighlight, shouldSelect, shouldHighlight, de/selecting cells programatically, etc.)
  - One issue that made me stuck for days was there was tiny pixel gap between date cells that I couldn't remove. I posted the solution here: http://stackoverflow.com/a/42574952/2105910

### Project 3 - Main Screen

![main screen](https://media.giphy.com/media/xUPGclujPdwArPBpsI/giphy.gif)

Things I learn:
  - How to make iOS Frameworks (using the previous 2 components in this screen)
  - UITableView header animation (view position & alpha change as user scrolls)
  - Custom page tab navigation with underline border that animates to selected page (For You, Homes, Experience, Places)
  - Nested UICollectionView inside UITableView

### Project 4 - Custom Page Transition

![page transition](https://media.giphy.com/media/xUPGcIN2PQiHGgxv4k/giphy.gif)

Things I learn:
  - A lot from here: https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions and here: http://blog.matthewcheok.com/design-teardown-preview-expanding-cells/
  - How to slice and snapshot views to animate transition on present and dismiss
  - New AirbnbReview component

# Coming Soon

This is an ongoing project and a lot of things already planned!

- ~~Page transition animation on selecting home item~~
- The map view! (that all other booking apps copy :D)
- Home detail screen
- My trips screen
- or you let me know what you wanna see!

# Resources
[Michigan Labs]

[Raywenderlich]

[Pexels]

[Icons 8]

[Let's Build That App]

# License

Swift of Airbnb is licensed under MIT License

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [Allen Wong's 30 Days of Swift]: <https://github.com/joemccann/dillinger.git>
   [Sam Lu's 100 Days of Swift]: <http://samvlu.com/index.html>
   [Michigan Labs]: <https://michiganlabs.com/ios/development/2016/05/31/ios-animating-uitableview-header/>
   [Raywenderlich]: <https://www.raywenderlich.com/>
   [Pexels]: <https://www.pexels.com>
   [Icons 8]: <https://icons8.com/>
   [Let's Build That App]: <https://www.letsbuildthatapp.com/>
  
