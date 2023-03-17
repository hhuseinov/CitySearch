# iOS home-task assignment

The goal of this assignment is to evaluate the problem solving skills, UX judgement and code quality of the candidate.

We have a list of cities containing around 200k entries in JSON format. Each entry contains the following information:

```
{
    "country":"UA",
    "name":"Hurzuf",
    "_id":707860,
    "coord":{
        "lon":34.283333,
        "lat":44.549999
    }
}
```

Your task is to:
* Load the list of cities from [here](cities.json).
* Be able to filter the results by a given prefix string, following these requirements:
     * Follow the prefix definition specified in the clarifications section below.
     * Implement a search algorithm optimised for fast runtime searches. Initial loading time of the app does not matter.
     * Search is case insensitive.
     * **Time efficiency for filter algorithm should be better than linear**
* Display these cities in a scrollable list, in alphabetical order (city first, country after). Hence, "Denver, US" should appear before "Sydney, Australia".
     * The UI should be as responsive as possible while typing in a filter.
     * The list should be updated with every character added/removed to/from the filter.
* Each city's cell should:
     * Show the city and country code as title.
     * Show the coordinates as subtitle.
     * When tapped, show the location of that city on a map.
* Provide unit tests showing that your search algorithm is displaying the correct results giving different inputs, including invalid inputs.

## Additional requirements/restrictions:
* The list will be provided to you as a plain text JSON format array.
* You can preprocess the list into any other representation that you consider more efficient
for searches and display. Provide information of why that representation is more efficient
in the comments of the code.
* Database implementations are forbidden
* Provide unit tests, that your search algorithm is displaying the correct results giving
different inputs, including invalid inputs.
* Alpha/beta versions of the IDE are forbidden, you must work with the stable version of
the IDE
* The code of the assignment has to be delivered along with the git repository (.git folder).
We want to see the progress evolution
* Swift UI, Programmatic UI, Segues, Reactive programming and third party libraries are prohibided.
* Supports iOS 13.
* Language must be Swift

Assume that project:
- Has 20+ iOS developers that are working in the same project.

Must have:
- Any modern architecture, you should explain why did you choose that architecture instead of others in TechnicalDecisions.txt file.
- All best practices
- Unit Tests for all cases
- clean(short and atomic) and meaningful git commit history(working on one single branch is enough)
- If you are in doubt and your topic is not in "Nice to have", then it is in "Must to have"

Nice to have:
- localisation(just for English)
- dark mode support(switches instantly smoothly without needing to force to kill the application and restarts again or without updating rootViewController)
- supporting both smallest screen size(i.e. iPhone SE 1st gen) and bigger screen size(iPad)
- Screen rotation support

Your code should be:
- Readable
- Reusable
- Testable
- Extendable
- Maintainable
- Separation of Concerns
- Defensive (not error prone)
- Well structured
- Well organised
- Ready to be modularised
- Avoid crashes
- Common Swift style guide / code conventions
- Less app size
- Fast build time
- Fast running code


## Clarifications
We define a prefix string as: a substring that matches the initial characters of the target string. For instance, assume the following entries:

* Alabama, US
* Albuquerque, US
* Anaheim, US
* Arizona, US
* Sydney, AU

If the given prefix is "A", all cities but Sydney should appear. Contrariwise, if the given prefix is "s", the only result should be "Sydney, AU".
If the given prefix is "Al", "Alabama, US" and "Albuquerque, US" are the only results.
If the prefix given is "Alb" then the only result is "Albuquerque, US"
