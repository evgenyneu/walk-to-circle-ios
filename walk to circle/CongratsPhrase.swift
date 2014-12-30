//
//  CongratsTitle.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 30/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public var walkCongratsPhrases = [
  1: [
    "Good start",
    "Good job",
    "Good work",
    "OK",
    "Good remembering",
    "That's good"
  ],
  2: [
    "Congratulations",
    "Good going",
    "You remembered",
    "Nice going",
    "Now you have the hang of it",
    "Now you've figured it out",
    "You've got it now",
    "Way to go",
    "Keep it up",
    "Great",
    "That's it",
    "You got it right",
    "You're doing a good job",
    "That's the way",
    "That's great",
    "You're doing fine",
    "You're on the right track now",
    "Wonderful"
  ],
  5: [
    "That's really nice",
    "Nothing can stop you now",
    "Well, look at you go",
    "You're really going to town",
    "Excellent job",
    "You did that very well",
    "You did a very fine job",
    "You're doing beautifully",
    "You've done a great job"
  ],
  8: [
    "Terrific",
    "Super duper",
    "Fantastic",
    "Perfect",
    "You make it look easy",
    "Sensational",
    "Superb",
    "Top-notch",
    "Tremendous",
    "Splendid",
    "Incredible",
    "Let’s tell the boss"
  ],
  13: [
    "That deserves a hug",
    "You outdid yourself today",
    "You are very good at that",
    "You certainly did well today",
    "That's the best ever",
    "That's better than ever",
    "You must have been practising",
    "Best yet",
    "Dynamite",
    "Outstanding",
    "You've just about mastered that",
    "Beyond cool",
    "Now you know the map better than a taxi driver",
    "Amazing. We almost ran out of 'good job' phrases"
  ],
  20: [
    "Holy Figs!",
    "Oh My Glob!",
    "Algebraic!",
    "Mathematical!",
    "Shmowzow!"
  ]
]

public var walkCongratsPhrasesSeenToday = [String]()

public let walkCongratsNoPhraseFound = "Oops. We ran out of 'good job' phrases. Finally!"

public class CongratsPhrase {
  public class func oneRandomPhrase(circlesReachedToday: Int) -> String {
    var phrases = getPhrases(circlesReachedToday)
    phrases = unseenPhrasesToday(phrases)

    let randomPhrase = oneRandomPhrase(phrases)
    rememberSeenPhrase(randomPhrase)
    
    return randomPhrase
  }

  private class func rememberSeenPhrase(phrase: String) {
    if contains(walkCongratsPhrasesSeenToday, phrase) { return }
    walkCongratsPhrasesSeenToday.append(phrase)
  }

  public class func oneRandomPhrase(phrases: [String]) -> String {
    return iiRandom.random(phrases) ?? walkCongratsNoPhraseFound
  }

  public class func getPhrases(circlesReachedToday: Int) -> [String] {
    let numbers = walkCongratsPhrases.keys.array.sorted { $0 < $1 }

    var currentNumber = numbers.first ?? 1

    for number in numbers {
      if number > circlesReachedToday { break }
      currentNumber = number
    }

    if let currentPhrases = walkCongratsPhrases[currentNumber] {
      return currentPhrases
    }

    return [walkCongratsNoPhraseFound]
  }

  public class func unseenPhrasesToday(allPhrases: [String]) -> [String] {
    var unseen = unseenPhrasesToday(allPhrases, alreadySeenToday: walkCongratsPhrasesSeenToday)

    if unseen.isEmpty {
      // Seen all phrases today - reset
      unseen = allPhrases
      walkCongratsPhrasesSeenToday = []
    }

    return unseen
  }

  public class func unseenPhrasesToday(allPhrases: [String],
    alreadySeenToday: [String]) -> [String] {
      
    return allPhrases.filter { phrase in
      return !contains(alreadySeenToday, phrase)
    }
  }
}
