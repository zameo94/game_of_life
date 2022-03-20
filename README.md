# README
## Index
* [Intro](#intro)
* [Prerequisites](#prerequisites)
* [Installation](#installation)
* [Play](#play)


##Intro
This simple Ruby on Rails application reproduce the Conway's Game of life.
You can find more details about visiting [Wikipedia](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

This application was created to be as light as a possible.

There is no ActiveRecords or Migrations, having the only goal of print the evolution of a matrix (following the Game of life rules)
through a pattern like the example below:

```
Generation 3:
4 8
........
....*...
...**...
........
```

The only matrices allowed are those with a single digit number(1...9) for both rows and columns

Was tested on:

* Ubuntu 20.04.3 LTS / Macos 12.3
* Ruby 2.6.6
* Rails 5.2.7

## Prerequisites
* Ruby 2.6.6
* Rails 5.2.7

## Installation
* Download the project
```
git clone https://github.com/zameo94/game_of_life.git
```
* Enter in the project's directory
```
cd game_of_life
```

* Install gems
```
bundle install 
```

Congratulations, all are ready

If you want to run Rspec tests, just go in the project directory and type:
```
rspec spec
```

## Play
This applications implements 2 examples. For prove them, just type the right command on the project's directory.

* Example 1:
    ```
    rake game_of_life:run_sample
    ```
    File:
    ```
    Generation 3:
    4 8
    ........
    ....*...
    ...**...
    ........
    ```

* Example 2:
    ```
    rake game_of_life:run_sample2
    ```
    File:
    ```
    Generation 1:
    5 5
    .....
    .....
    .***.
    .....
    .....
    ```

To stop the interactions, just type:
```
Ubuntu: ctrl + c
Macos: ^ + c
```
Enjoy!