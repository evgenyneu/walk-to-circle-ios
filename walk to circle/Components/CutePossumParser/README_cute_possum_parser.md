# JSON parser for iOS and Swift

This parser is designed to convert JSON text into Swift structs and classes.

## Setup

Copy [CutePossumParser.swift](https://github.com/exchangegroup/cute-possum-parser/blob/master/cute-possum-parser/CutePossumParser.swift) file to your project.

## Example

We want to convert the JSON:

```JSON
{
"name": "Cutie the possum",
"lengthCM": 31,
"weightKG": 2.2,
"likes": ["leaves", "carrots", "strawberries"],
"plans": null,
"spouse": "Mikrla the possum",
"home": {
"planet": "Earth"
},

"friends": [
{
"name": "Pinky the wombat",
"likesLeaves": true
},
{
"name": "Fluffy the platypus",
"likesLeaves": false
}
]
}
```

into the Swift stucts:

```Swift
struct Possum {
let name: String
let species: String
let lengthCM: Int
let weightKG: Double
let likes: [String]
let plans: [String]?
let spouse: String?
let bio: String?
let home: Address
let friends: [Friend]
}

struct Address {
let planet: String
}

struct Friend {
let name: String
let likesLeaves: Bool
}
```

### Parsing code

```Swift
let p = CutePossumParser(json: json)

let model = Possum(
name: p.parse("name", miss: ""),
species: p.parse("species", miss: "", canBeMissing: true),
lengthCM: p.parse("lengthCM", miss: 0),
weightKG: p.parse("weightKG", miss: 0),
likes: p.parse("likes", miss: []),
plans: p.parseOptional("plans"),
spouse: p.parseOptional("spouse"),
bio: p.parseOptional("bio"),

home: Address(
planet: p["home"].parse("planet", miss: "")
),

friends: p.parseArray("friends", miss: [], parser: { p in

return Friend(
name: p.parse("name", miss: ""),
likesLeaves: p.parse("likesLeaves", miss: true)
)

})
)

if !p.success { // report failure if necessary }
```

See other examples in this [unit test](https://github.com/exchangegroup/cute-possum-parser/blob/master/cute-possum-parserTests/cute_possum_parserTests.swift).


## Project home

https://github.com/exchangegroup/cute-possum-parser/tree/master/cute-possum-parser
