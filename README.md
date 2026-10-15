## PROJECT ##

* ID: **A**WA.com!**P**ATCHES
* Contact: dev@schepsen.eu

## DESCRIPTION ##

**A**WA.com!**P**ATCHES is a collection of reverse-engineered patch files and helper scripts for Alienware daily quests and browser games. It includes gameplay tweaks, automation shortcuts, and local override workflows for studying and modifying original game code in a controlled, educational setting.

## QUESTS ##

#### HTML5 GAMES ####

* Behind the Asteroids <sub>October 15th, 2026</sub>
  * The asteroid velocity is increased by 10x.
  * Rotation oscillation is disabled.
  * The random shooting key has been reduced to a single key: press "**S**" to fire with auto-aim.

* Portal Puzzle <sub>October 6th, 2026</sub>
  * Press "**C**" to auto-complete the puzzle.

#### ADVERTISING ####

* Alienware M16 R2 <sub>April 6th, 2024</sub> [[Source](https://secure.cataboom.com/remote/awa-alienware-m16-r2-wt/assets/js/mechanic.js)]

#### DAILY QUESTS ####

* Match IT <sub>April 1st, 2024</sub> [[Preview](preview/day-1-matchit-us-awa-fruit-blade.gif)] [[Source](https://secure.cataboom.com/remote/day-1-matchit-us-awa-fruit-blade-entry/assets/js/mechanic.js)]
* Memory <sub>April 4th, 2024</sub> [[Preview](preview/day-4-memory-us-awa-fruit-blade.gif)] [[Source](https://secure.cataboom.com/remote/day-4-memory-us-awa-fruit-blade-entry/assets/js/mechanic.js)]
* Puzzle <sub>April 3rd, 2024</sub> [[Preview](preview/day-3-puzzle-us-awa-fruit-blade.gif)] [[Source](https://secure.cataboom.com/remote/day-3-puzzle-us-awa-fruit-blade-entry/assets/js/mechanic.js)]
* Word Fury <sub>April 2nd, 2024</sub> [[Preview](preview/day-2-wordfury-us-awa-fruit-blade.gif)] [[Source](https://secure.cataboom.com/remote/day-2-wordfury-us-awa-fruit-blade-entry/assets/js/mechanic.js)]

#### BONUS GAMES ####

* Fruit Blade <sub>latest update on April 8th, 2024</sub> [[Preview](preview/restricted-us-awa-fruit-blade-game.gif)] [[Source](https://secure.cataboom.com/game/restricted-us-awa-fruit-blade-game/660e9204-6d57-49ee-836d-e309003b6adb/game.js)]

## DISCLAIMER ##

All patches are published for educational purposes only. Use at your own risk.

## USAGE ##

1. Clone this repository.
2. Run `apply.sh <game-id>` to apply the patch to the original source code.
3. Use the patched source in Chrome DevTools as `Local Overrides`.

## USAGE (OUTDATED) ##

Apply a patch to the desired daily quest source file and use it afterwards in Chrome DevTools as `Local Overrides`.