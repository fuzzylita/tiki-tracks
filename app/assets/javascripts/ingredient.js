function createIngredient() {
  let fieldName = $("#new-ingredient").val()
  let newIng = {
    ingredient: {
      name: fieldName
    }
  }

  $.post("/ingredients", newIng).done(function(resp){
    $("#ingredients-list").append(`<li><strong>${resp.name}</strong></li>`)
    $("#new-ingredient").val("")
  }, "json").fail(function(xhr, status, error) {
    $("#error").empty()
    $("#error").append(`<div class="alert alert-danger">${xhr.responseText}</div>`)
  })
  
}