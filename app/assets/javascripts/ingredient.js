function createIngredient() {
  let fieldName = $("#new-ingredient").val()
  let newIng = {
    ingredient: {
      name: fieldName
    }
  }

  $.post("/ingredients", newIng).done(function(resp){
    $("#new-ingredient").val("")
    ingredientsList()
  }, "json").fail(function(xhr, status, error) {
    $("#error").empty()
    $("#error").append(`<div class="alert alert-danger">${xhr.responseText}</div>`)
  })  
}

function ingredientsList() {
  $.getJSON('/ingredients', (resp) => {
    
    let ings = ""
    resp.forEach((ing) => {
      ings += `<li><strong>${ing.name}</strong></li>`
    })
    
    $('#ingredients-list').html(ings)
  })
}