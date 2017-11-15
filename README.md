# Tiki-Tracks - Rails-based Cocktail CMS

## Overview
A simple, content management system for cocktail recipes. Once signed up, users can create cocktails and and save them to their personal library. Users can create drinks and ingredients, which are added to the communal database. Users can manage their own recipes, and can view the complete list of recipes for all users, but write permissions are restricted to their own drinks. 

## Requirements

- Rails

## Installation
1. [Fork and clone](https://help.github.com/articles/cloning-a-repository/) this repository to your local environment.

2. Install the needed gems:

```
$ bundle install
```

3. Migrate and seed the database:

```
$ rails db:migrate
$ rails db:seed
```

4. Run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

5. Navigate to http:localhost:3000 to get started.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fuzzylita/tiki-tracks. 

## License

This application is available as open source under the terms of the [MIT License](https://github.com/fuzzylita/tiki-tracks/blob/master/LICENSE).
