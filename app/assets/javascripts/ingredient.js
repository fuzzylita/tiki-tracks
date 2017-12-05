function createIngredient() {
  let fieldName = $("#new-ingredient").val()
  debugger
  let newIng = {
    ingredient: {
      name: escape(fieldName)
    }
  }

  $.post("/ingredients", newIng).done(function(resp){
    $("#ingredients-list").append(`<li><strong>${resp.name}</strong></li>`)
  }, "json").fail(function(xhr, status, error) {
    $("#error").empty()
    $("#error").append(`<div class="alert alert-danger">${xhr.responseText}</div>`)
  })
}