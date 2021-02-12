# UFood

## About

The application is a food diary with the function of calculating and review of the eaten nutrients.

Compatible with iOS 12 and newer.

The current functionality of the application consists of two main user flows: **food diary** and **statistics**.

Diary's features: 
  - shows eaten foods by days
  - allows to user add new days and foods, also delete existing ones
  - has a convenient search of foods in the database
  - there is a color marker for each food, thanks to which user can group foods (for example, related to breakfast or dinner)
  - user can open a detailed view of each food in which he can edit the weight and color of the marker of food 
  - also detailed food's view shows the nutrients contained in the food
  - there is also a helper view for choosing the weight of the food, which loads various portions from the database with the corresponding weight

Statistics features:
  - allows to user can choose one of several time periods
  - shows the eaten nutrients for this period with the percentage of the consumed amount to the norm
  - user can open a detailed view of any of the nutrients, in which he can see in which foods and how much contains of this nutrient

*To this repository has been added a demo version of food's database.*

*Copyright © 2020-2021 Macnolia. All rights reserved.*

## Technology Stack

  - Swift - programming language. 
  - UIKit - UI framework. 
  - MVP - architecture pattern for separating business and UI logics.
  - SQLite - store of common food's database. As layer over SQLite used framework SQLite.swift (installed with dependency manager CocoaPods).
  - CoreData - store of user's data. 
  - AutoLayout with programmatic implementation - to create an adaptive interface.

## Screenshots...
