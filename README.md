# Tiki-Tracks - Rails based Social Cocktail CMS

## Overview
A simple, content management system for cocktail recipes. Once signed up, users can create cocktails and and save them to their personal library. Users can create drinks and ingredients, which are added to the communal database. Users can manage their own recipes, and instantly generate liquor shopping lists by filtering out a list of ingredients specific to their cocktail library. Users can view the complete list of recipes for all users, but write permissions are restricted to their own drinks. 

## Requirements

- Rails

## Installation
1. [Fork and clone](https://help.github.com/articles/cloning-a-repository/) this repository to your local environment.

2. Iinstall the needed gems:

```
$ bundle install --without production
```

3. Migrate the database:

```
$ rails db:migrate
```

4. Run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```
```
5. Navigate to http:localhost:3000 to get started.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fuzzylita/tiki-tracks. 

## License

This application is available as open source under the terms of the [MIT License](https://github.com/fuzzylita/tiki-tracks/blob/master/LICENSE).