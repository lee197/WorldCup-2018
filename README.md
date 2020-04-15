# WorldCup-2018
An app to display a list of world cups teams and groups with flag

## Branches:

* master - stable app releases
* develop - development branch, merge features branches here

## WorldCup-2018 API:
https://github.com/lee197/WorldCup-2018/blob/master/WorldCup2018/WorldCup2018.json

## Dependencies:

The project is not using any cocoapods for managing external libraries.

## Project structure:

* ViewModel: Viewmodel objects with business logics 
* Model: Model objects
* Data Service: Contains APIService and API json file for testing
* ViewControleller: Connection between View and ViewModels
* Unit Test: Contains tests for ViewModel file

## Next step:

* Fix the bug of image self-sizing
* Optimize the searching functions in ViewModel
* create unit test to cover searching functions
