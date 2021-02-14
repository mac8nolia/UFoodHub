# UFood

**The application is a food diary with the function of calculating and review of the eaten nutrients.**

![Main screen](https://user-images.githubusercontent.com/77031399/107876625-1c329380-6ed8-11eb-870b-a745f06f6b55.png)

## Features

The current functionality of the application consists of two main user flows: food diary and statistics.

**Diary's features:** 
  - shows eaten foods by days
  - allows to user add new days and foods, also delete existing ones
  - has a convenient search of foods in the database
  - there is a color marker for each food, thanks to which user can group foods (for example, related to breakfast or dinner)
  - user can open a detailed view of each food in which he can edit the weight and color of the marker of food 
  - also detailed food's view shows the nutrients contained in the food
  - there is also a helper view for choosing the weight of the food, which loads various portions from the database with the corresponding weight

**Statistics features:**
  - allows to user can choose one of several time periods
  - shows the eaten nutrients for this period with the percentage of the consumed amount to the norm
  - user can open a detailed view of any of the nutrients, in which he can see in which foods and how much contains of this nutrient

Compatible with iOS 12 and newer.

*To this repository has been added a demo version of food's database.*

## Technology Stack

  - **Swift** - programming language. 
  - **UIKit** - UI framework. 
  - **MVP** - architecture pattern for separating business and UI logics.
  - **SQLite** - store of common food's database. As layer over SQLite used framework [SQLite.swift](https://github.com/stephencelis/SQLite.swift) (installed with dependency manager CocoaPods).
  - **CoreData** - store of user's data. 
  - **AutoLayout with programmatic implementation** - to create an adaptive interface.

## Screenshots

<img width="379" alt="screen1" src="https://user-images.githubusercontent.com/77031399/107877715-273cf200-6edf-11eb-85fb-ebf96f3e9dc6.png">
<img width="378" alt="screen2" src="https://user-images.githubusercontent.com/77031399/107877720-2a37e280-6edf-11eb-97a1-fafb502bdeab.png">
<img width="731" alt="screen3" src="https://user-images.githubusercontent.com/77031399/107877721-2b690f80-6edf-11eb-9efd-713be5cf7a10.png">
<img width="377" alt="screen4" src="https://user-images.githubusercontent.com/77031399/107877722-2c01a600-6edf-11eb-8df8-35fd50b430e1.png">
<img width="387" alt="screen5" src="https://user-images.githubusercontent.com/77031399/107882720-1b135d80-6efc-11eb-9251-9f1bbdf10605.png">
<img width="739" alt="screen6" src="https://user-images.githubusercontent.com/77031399/107877725-2c9a3c80-6edf-11eb-8754-b724505d13f6.png">
<img width="388" alt="screen7" src="https://user-images.githubusercontent.com/77031399/107877727-2d32d300-6edf-11eb-8d4e-6886c1afd8c7.png">

*Copyright © 2020-2021 Macnolia. All rights reserved.*
