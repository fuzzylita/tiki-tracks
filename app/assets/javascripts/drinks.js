class Drink {
  constructor(drink) {
    this.id = drink.id
    this.name = drink.name
    this.instructions = drink.instructions
    this.user_id = drink.user_id
    this.created_at = new Date(drink.created_at)
    this.username = drink.username
    this.unformatted_rating = drink.rating
    this.ingredients = drink.ingredients
  }

  // this method just shows the date more nicely in the index page

  formatted_date() {
    return this.created_at.toLocaleDateString()
  }

  // this method is a custom getter that allows the JS obj to display a more
  // user friendly message. It could have been done in the template, but I felt it was
  // more closely related to the state of the object, so made sense to include

  get rating() {
    if (this.unformatted_rating === null) {
      return "Not Rated Yet!"
    }
    return this.unformatted_rating
  }
}

// **** HELPERS ****

function linkTo(name, path) {
  return `<a href="${path}">${name}</a>`
}

// **** INDEX PAGE TEMPLATE ****

// we append the drinks list to an empty div which is sitting on the page.

function getDrinks(path) {
  $.getJSON(path, (resp) => {
    if (resp === null ) {
      $("#drinks_list").append(`
      <h1>There are no drinks!</h1>
      `)
    }

    resp.forEach(function(item) {
      let drink = new Drink(item)
      $("#drinks_list").append(`
      <li>
        <strong>${linkTo(drink.name, `${path}/${drink.id}`)}</strong><br>
        Created by ${drink.username} on ${drink.formatted_date()}<br>
        Rating: ${drink.rating}
      </li><br>
      `)
    })
  })
}

// **** DRINK DETAIL PAGE CONTENT ****

function getDrink(path) {
  $.getJSON(path, (resp) => {
    if (resp === null ) {
      $("#drink_info").append(`
      <h1>Drink does not exist!</h1>
      `)
    }

    let drink = new Drink(resp)
    $("#drink_info").append(`
      <h1>
        ${drink.name}!
      </h1>

      Drink Rating:
      <input id="current_rating" type="text" class="rating" data-size="xs"><br>

      <p><strong>Ingredients: </strong></p>
      <ul id="ingredients_list">
      </ul>

      <p><strong>Instructions: </strong></p>
      <ul>
        <li>${drink.instructions}</li>
      </ul>
      <br>
    `)

    // This comes from the star_rating library to translate the rating visually into stars. 
    // This syntax below comes from the documentation for that library. 
    // First line is a configuration setting specifed, second is the command that sets the display val.
    // 'rating' here is not related to the rating for the drink, the library has a custom jquery method
    // on elements 
    
    $("#current_rating").rating("refresh", {displayOnly: true, showCaption: false, showClear: false}); // displays uneditable current rating on the screen
    $("#current_rating").rating("update", drink.rating)

    // the template is created above, now I'm going to append each ingredient as an li to that list

    let ing = $("#ingredients_list")

    drink.ingredients.forEach(function(el) {
      ing.append(`
      <li>${el.name} - ${el.quantity}</li>      
      `)
    })

    // only the public view should show the message about making a drink a proper cocktail

    if (drink.ingredients.length === 3 && path.includes("users") === false) {
      ing.append(`
      <li>Add bitters to make a proper cocktail!</li>
      `)
    }
  })
}

// **** DYNAMICALLY ADD FIELDS TO FORM ****

function addIngredientFields() {
  let newFields = $(".ingredient-selector")[0].cloneNode(true)
  newFields.children[0].value = ""
  newFields.children[2].value = ""
  $("#ingredient-appender").append(newFields)
}
