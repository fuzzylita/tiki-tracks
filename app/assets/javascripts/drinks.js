class Drink {
  constructor(drink) {
    this.id = drink.id
    this.name = drink.name
    this.instructions = drink.instructions
    this.user_id = drink.user_id
    this.created_at = new Date(drink.created_at)
    this.username = drink.username
    this._rating = drink.rating
    this.ingredients = drink.ingredients
  }

  formatted_date() {
    return this.created_at.toLocaleDateString()
  }

  get rating() {
    if (this._rating === null) {
      return "Not Rated Yet!"
    }
    return this._rating
  }
}

// **** HELPERS ****

function linkTo(name, path) {
  return `<a href="${path}">${name}</a>`
}

// **** INDEX PAGE TEMPLATE ****

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
      <div id="rating">${drink.rating}</div><br>

      <p><strong>Ingredients: </strong></p>
      <ul id="ingredients_list">
      </ul>

      <p><strong>Instructions: </strong></p>
      <ul>
        <li>${drink.instructions}</li>
      </ul>
      <br>
    `)

    let ing = $("#ingredients_list")

    drink.ingredients.forEach(function(el) {
      ing.append(`
      <li>${el.name} - ${el.quantity}</li>      
      `)
    })

    if (drink.ingredients.length === 3 && path.includes("users") === false) {
      ing.append(`
      <li>Add bitters to make a proper cocktail!</li>
      `)
    }
  })
}