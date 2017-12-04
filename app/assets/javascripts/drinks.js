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

function linkTo(name, path) {
  return `<a href="${path}">${name}</a>`
}

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

      <p><strong>Ingredients: </strong></p>
      <ul id="ingredients_list">
      </ul>

      <p><strong>Instructions: </strong></p>
      <ul>
        <li>${drink.instructions}</li>
      </ul>
      <%= render partial: 'ratings/rate_form', locals: { drink: @drink } %>
      <br>
    `)

    let ing = $("#ingredients_list")

    drink.ingredients.forEach(function(el) {
      ing.append(`
      <li>${el.name} - ${el.quantity}</li>      
      `)
    })
  })
}
