# Completed Project
<img src="https://github.com/thomasdye/ios-sprint-challenge-password-textfield/blob/master/password.gif" height="500px">

# Sprint Challenge: iOS User Interface - Password TextField

This challenge allows you to practice the concepts and techniques learned over the past week and apply them in a concrete project. This sprint provided an exploration of building interfaces for iOS apps. In your challenge this week, you will demonstrate proficiency by creating an application that uses a custom `UIControl` to show a password field and measure the strength of passwords entered.

## Instructions

**Read these instructions carefully. Understand exactly what is expected _before_ starting this Sprint Challenge.**

This is an individual assessment. All work must be your own. Your challenge score is a measure of your ability to work independently using the material covered through this sprint. You need to demonstrate proficiency in the concepts and objectives introduced and practiced in preceding days.

You are not allowed to collaborate during the Sprint Challenge. However, you are encouraged to follow the twenty-minute rule and seek support from your TL and Instructor in your cohort help channel on Slack. Your work reflects your proficiency in iOS and your command of the concepts and techniques in this first unit.

You have three hours to complete this challenge. Plan your time accordingly.

## Commits

Commit your code regularly and meaningfully. This helps both you (in case you ever need to return to old code for any number of reasons) and your team lead.

## Description

In this challenge, you will build an app that shows a custom password field control. The following mockup was used as a basis for the custom control you'll make.

https://dribbble.com/shots/3691036-Password-Strength-Option-3

In meeting the minimum viable product (MVP) specifications listed below, your application will be able to show the password field as designed above and accept text from the user. It will then grade the strength of the password and display various color indicators and a label with different text explaining the strength of the password entered. It will also allow the containing view controller to receive the password text and the strength through the target-action pattern.

In your solution project, it is essential that you follow best practices and produce clean and professional results. Schedule time to review, refine, and assess your work and perform basic professional polishing including spell-checking and grammar-checking on your work. It is better to submit a challenge that meets the minimum requirements than one that attempts too much and does not.

Validate your work through testing the app on the simulator and ensure that your code operates as designed.

## Project Set Up

This repository contains a starter project. Use this project as the basis for your work.

Please fork this repository and clone the fork to your machine to begin work.

## Minimum Viable Product

This repository contains a basic project that includes artwork, colors, and basic layout constants defined for the custom control. Use this project as the basis for your work.

![Demo GIF of functionality](https://raw.githubusercontent.com/LambdaSchool/ios-sprint-challenge-password-textfield/master/ui-demo.gif)

Your finished project must include all of the following requirements:

* A label that provides directions to the user for the purpose of the control ("enter password").
* A textfield that accepts text with the contents hidden or shown depending on the state of the show/hide button. The textfield should have a blue border that wraps around the textfield itself and the show/hide button.
* A show/hide button that uses the included eye image assets to represent the secure state of the textfield.
* 3 strength indicators (views) that present either red, orange, or green colors to indicate the strength of the text entered into the password textfield.
    * When these indicators need to change state, animate the change. Change the color and transform the vertical size of the highest attained level briefly. For example, going from "weak" to "medium", the orange indicator should briefly increase in vertical size, and then return to its original size. See the demo GIF.
* A label that displays "too weak", "could be stronger", or "strong password" as a written indication of password strength.
* As each new character is entered by the user into the textfield, the control should analyze the text and determine the strength of it as a password. The only requirements are length (see stretch goal for additional rules). The example GIF shows weak=0-9, medium=10-19, strong=20+, but feel free to create a different scale if you wish.
* The control should keep all of its inner workings private except for two items: a string to hold the final password value (provided in the starter), and a strength value (could be implemented as a custom enum). Both should be readonly.
* Use the constants provided in the starter project for colors, margins, sizes, etc. Auto Layout should be used to show subviews within the control, but using programmatic layout only (the storyboard is already set up for you in the starter). You may use `NSLayoutConstraint` or `NSLayoutAnchor` to lay out your views in code.
* When the user taps the "return" key on the keyboard, the control should hide the keyboard and then signal to the containing view controller that the value of the password has changed using the target-action pattern (use the event type `valueChanged`). You'll need an `IBAction` that is wired to this event on the control in the view controller. When that event fires, simply print the password value and its strength to the console from the view controller.

## Stretch Problems (Optional)

After finishing your required elements, you can push your work further. These goals may or may not be things you have learned in this module but they build on the material you just studied. Time allowing, stretch your limits and see if you can deliver on the following optional goals:

* In addition to checking for the length of the password, check whether the text entered is a dictionary word. If so, demote the strength of the password by 1 level. For example, if a 10 character password would be medium strength, but it is found in a simple dictionary search, the control would report that password to be weak instead.
    * HINT: You can use a method in the `UIReferenceLibraryViewController` class to check whether a word is in the dictionary.
    * NOTE on above: If you're testing with the simulator, you'll need to install a dictionary before the above method will work. Go to the `ViewController` class and uncomment and read the directions there to do this one-time setup step before you work on this stretch goal.
